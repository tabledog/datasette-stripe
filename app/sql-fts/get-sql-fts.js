const util = require('util');
const exec = util.promisify(require('child_process').exec);

// This script takes the absolute path to a SQLite database and outputs FTS SQL for every table.
// - The SQLite FTS feature requires three types of SQL:
//      - 1. Create FTS table.
//      - 2. Populate that FTS table with existing rows.
//      - 3. Triggers to keep the FTS table up to date with table writes.
//
// - Excludes TD metadata (Primary key ID, insert/update timestamps).
// - Usage: get-sql-fts.js /db.sqlite > fts.sql.


const args = process.argv.slice(2);
const target_db = args[0];


const get_tables = async (abs_db) => {
    const x = await exec(`sqlite3 ${abs_db} ".mode json" "select * from sqlite_master where type='table'"`);
    const tables = JSON.parse(x.stdout);
    await add_cols(abs_db, tables);
    return tables;
}

const get_table_cols = async (abs_db, table_name) => {
    const cols = JSON.parse((await exec(`sqlite3 ${abs_db} ".mode json" "PRAGMA table_info(${table_name})"`)).stdout);
    return cols;
}

const add_cols = async (abs_db, tables) => {
    for (const t of tables) {
        if (t.type === "table" && /^\s*?CREATE TABLE /.test(t.sql)) {
            const cols = await get_table_cols(abs_db, t.name);
            // Mutate tables, add the col names.
            t.cols = cols;
        }
    }
};


const get_fts_create_populate_and_triggers = (tables) => {
    const create = [];
    const populate = [];
    const trigger = [];


    for (const t of tables) {
        const include_table_in_fts = (t) => (
            t.type === "table" &&
            "cols" in t && t.cols.length > 0 &&
            !/fts_[a-z]+$/.test(t.name) &&
            // E.g. `_litestream_seq`
            !/^_/.test(t.name) &&
            t.name !== "sqlite_sequence"
        );

        if (include_table_in_fts(t)) {

            const is_metadata = (c) => {
                return (
                    /^(update_ts|insert_ts)$/.test(c.name) ||
                    (/_id$/.test(c.name) && c.pk === 1)
                )
            };

            // Not row metadata.
            const to_index = t.cols.filter((c) => !is_metadata(c));
            const col_names_id = to_index.map((c) => `[${c.name}]`);
            const col_names_csv = col_names_id.join(`, `);

            const fts_tbl = `[${t.name}_fts]`;

            create.push(`CREATE VIRTUAL TABLE ${fts_tbl} USING FTS5 (${col_names_csv}, content=[${t.name}]);`);
            populate.push(`INSERT INTO ${fts_tbl} (rowid, ${col_names_csv}) SELECT rowid, ${col_names_csv} FROM [${t.name}];`);

            const ins = `INSERT INTO ${fts_tbl} (rowid, ${col_names_csv}) VALUES (new.rowid, ${col_names_id.map((x)=> `new.${x}`).join(", ")});`;
            const del = `INSERT INTO ${fts_tbl} ([${t.name}_fts], rowid, ${col_names_csv}) VALUES('delete', old.rowid, ${col_names_id.map((x)=> `old.${x}`).join(", ")});`;

            trigger.push([
                `CREATE TRIGGER [${t.name}_ai] AFTER INSERT ON [${t.name}] BEGIN ${ins} END;`,
                `CREATE TRIGGER [${t.name}_ad] AFTER DELETE ON [${t.name}] BEGIN ${del} END;`,
                `CREATE TRIGGER [${t.name}_au] AFTER UPDATE ON [${t.name}] BEGIN ${ins} ${del} END;`
            ].join("\n\n"));
        }
    }


    return {
        create,
        populate,
        trigger
    }
};


get_tables(target_db).then((tables) => {
    const sql = get_fts_create_populate_and_triggers(tables);
    console.log(`
        BEGIN IMMEDIATE TRANSACTION;
        
        ${sql.create.join("\n\n")}
        ${sql.populate.join("\n\n")}
        ${sql.trigger.join("\n\n")}
        
        COMMIT;
    `.trim());
});