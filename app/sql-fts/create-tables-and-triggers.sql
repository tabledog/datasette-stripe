BEGIN IMMEDIATE TRANSACTION;

CREATE VIRTUAL TABLE [balance_transactions_fts] USING FTS5 (
    [id], [type], [source], [available_on], [currency], [description], [fee_details], [reporting_category], [status], [created],
    content=[balance_transactions]
);
CREATE VIRTUAL TABLE [bank_accounts_fts] USING FTS5 (
    [id], [account], [customer], [account_holder_name], [account_holder_type], [available_payout_methods], [bank_name], [country], [currency], [fingerprint], [last4], [routing_number], [status],
    content=[bank_accounts]
);
CREATE VIRTUAL TABLE [cards_fts] USING FTS5 (
    [id], [name], [account], [customer], [recipient], [address_city], [address_country], [address_line1], [address_line1_check], [address_line2], [address_state], [address_zip], [address_zip_check], [available_payout_methods], [brand], [country], [currency], [cvc_check], [dynamic_last4], [fingerprint], [funding], [last4], [tokenization_method], [metadata],
    content=[cards]
);
CREATE VIRTUAL TABLE [charges_fts] USING FTS5 (
    [id], [application], [application_fee], [balance_transaction], [customer], [invoice], [on_behalf_of], [order_id], [payment_intent], [review], [source_transfer], [transfer], [billing_details], [calculated_statement_descriptor], [currency], [description], [failure_code], [failure_message], [fraud_details], [outcome], [payment_method], [payment_method_details], [payment_method_details_type], [receipt_email], [receipt_number], [receipt_url], [refunds], [shipping], [statement_descriptor], [statement_descriptor_suffix], [status], [transfer_data], [transfer_group], [created], [metadata],
    content=[charges]
);
CREATE VIRTUAL TABLE [coupons_fts] USING FTS5 (
    [id], [name], [applies_to], [currency], [duration], [metadata],
    content=[coupons]
);
CREATE VIRTUAL TABLE [credit_note_line_items_fts] USING FTS5 (
    [id], [type], [credit_note_id], [description], [discount_amounts], [invoice_line_item], [tax_amounts], [tax_rates], [unit_amount_decimal],
    content=[credit_note_line_items]
);
CREATE VIRTUAL TABLE [credit_notes_fts] USING FTS5 (
    [id], [type], [customer], [customer_balance_transaction], [invoice], [refund], [currency], [discount_amounts], [lines_first_x], [memo], [number], [pdf], [reason], [status], [tax_amounts], [voided_at], [created], [metadata],
    content=[credit_notes]
);
CREATE VIRTUAL TABLE [customers_fts] USING FTS5 (
    [id], [name], [email], [default_source], [address], [shipping], [currency], [description], [discount], [invoice_prefix], [invoice_settings], [phone], [preferred_locales], [tax_exempt], [created], [metadata],
    content=[customers]
);
CREATE VIRTUAL TABLE [discounts_fts] USING FTS5 (
    [id], [coupon], [customer], [subscription], [invoice], [invoice_item], [promotion_code], [checkout_session], [start], [end_ts],
    content=[discounts]
);
CREATE VIRTUAL TABLE [disputes_fts] USING FTS5 (
    [id], [charge], [payment_intent], [balance_transactions], [currency], [evidence], [evidence_details], [reason], [status], [created], [metadata],
    content=[disputes]
);
CREATE VIRTUAL TABLE [invoice_line_items_fts] USING FTS5 (
    [id], [type], [invoice], [invoice_item], [subscription], [subscription_item], [discounts], [currency], [description], [discount_amounts], [period_json], [price], [tax_amounts], [tax_rates], [metadata],
    content=[invoice_line_items]
);
CREATE VIRTUAL TABLE [invoiceitems_fts] USING FTS5 (
    [id], [customer], [invoice], [subscription], [subscription_item], [discounts], [currency], [date_ts], [description], [period_json], [price], [tax_rates], [unit_amount_decimal], [metadata],
    content=[invoiceitems]
);
CREATE VIRTUAL TABLE [invoices_fts] USING FTS5 (
    [id], [charge], [customer], [default_payment_method], [default_source], [discounts], [payment_intent], [subscription], [account_country], [account_name], [billing_reason], [collection_method], [currency], [custom_fields], [customer_address], [customer_email], [customer_name], [customer_phone], [customer_shipping], [customer_tax_exempt], [customer_tax_ids], [default_tax_rates], [description], [due_date], [footer], [hosted_invoice_url], [invoice_pdf], [last_finalization_error], [lines_newest_10], [next_payment_attempt], [number], [period_end], [period_start], [receipt_number], [statement_descriptor], [status], [status_transitions], [threshold_reason], [total_discount_amounts], [total_tax_amounts], [transfer_data], [webhooks_delivered_at], [created], [metadata],
    content=[invoices]
);
CREATE VIRTUAL TABLE [notification_events_fts] USING FTS5 (
    [id], [type], [resource], [action], [account], [api_version], [data_object_id], [data_object_object], [data_object], [data_previous_attributes], [request_id], [request_idempotency_key], [created],
    content=[notification_events]
);
CREATE VIRTUAL TABLE [order_returns_fts] USING FTS5 (
    [id], [order_id], [refund], [currency], [items], [created],
    content=[order_returns]
);
CREATE VIRTUAL TABLE [orders_fts] USING FTS5 (
    [id], [upstream_id], [charge], [customer], [application], [currency], [email], [external_coupon_code], [items], [returns], [selected_shipping_method], [shipping], [shipping_methods], [status], [status_transitions], [created], [updated], [metadata],
    content=[orders]
);
CREATE VIRTUAL TABLE [payment_intents_fts] USING FTS5 (
    [id], [application], [customer], [invoice], [on_behalf_of], [payment_method], [review], [canceled_at], [cancellation_reason], [capture_method], [client_secret], [confirmation_method], [currency], [description], [last_payment_error], [next_action], [payment_method_options], [payment_method_types], [receipt_email], [setup_future_usage], [shipping], [statement_descriptor], [statement_descriptor_suffix], [status], [transfer_data_destination], [transfer_group], [created], [metadata],
    content=[payment_intents]
);
CREATE VIRTUAL TABLE [payment_methods_fts] USING FTS5 (
    [type], [id], [customer], [alipay], [au_becs_debit], [bacs_debit], [bancontact], [billing_details], [card], [card_present], [eps], [fpx], [giropay], [grabpay], [ideal], [interac_present], [oxxo], [p24], [sepa_debit], [sofort], [created], [metadata],
    content=[payment_methods]
);
CREATE VIRTUAL TABLE [prices_fts] USING FTS5 (
    [id], [type], [product], [billing_scheme], [currency], [lookup_key], [nickname], [recurring], [tiers], [tiers_mode], [transform_quantity], [unit_amount_decimal], [created], [metadata],
    content=[prices]
);
CREATE VIRTUAL TABLE [products_fts] USING FTS5 (
    [id], [type], [name], [attributes], [caption], [deactivate_on], [description], [images], [package_dimensions], [statement_descriptor], [unit_label], [url], [updated], [created], [metadata],
    content=[products]
);
CREATE VIRTUAL TABLE [promotion_codes_fts] USING FTS5 (
    [id], [customer], [code], [coupon], [expires_at], [restrictions], [created], [metadata],
    content=[promotion_codes]
);
CREATE VIRTUAL TABLE [refunds_fts] USING FTS5 (
    [id], [balance_transaction], [charge], [failure_balance_transaction], [payment_intent], [source_transfer_reversal], [transfer_reversal], [currency], [description], [failure_reason], [reason], [receipt_number], [status], [created], [metadata],
    content=[refunds]
);
CREATE VIRTUAL TABLE [setup_intents_fts] USING FTS5 (
    [id], [application], [customer], [latest_attempt], [mandate], [on_behalf_of], [payment_method], [single_use_mandate], [cancellation_reason], [client_secret], [description], [last_setup_error], [next_action], [payment_method_options], [payment_method_types], [status], [usage_x], [created], [metadata],
    content=[setup_intents]
);
CREATE VIRTUAL TABLE [skus_fts] USING FTS5 (
    [id], [product], [attributes], [currency], [image], [inventory], [package_dimensions], [created], [updated], [metadata],
    content=[skus]
);
CREATE VIRTUAL TABLE [sources_fts] USING FTS5 (
    [id], [type], [customer], [ach_credit_transfer], [ach_debit], [alipay], [au_becs_debit], [bancontact], [card], [card_present], [client_secret], [code_verification], [currency], [eps], [flow], [giropay], [ideal], [klarna], [multibanco], [owner], [p24], [receiver], [redirect], [sepa_debit], [sofort], [source_order], [statement_descriptor], [status], [three_d_secure], [usage_x], [wechat], [created], [metadata],
    content=[sources]
);
CREATE VIRTUAL TABLE [subscription_items_fts] USING FTS5 (
    [id], [subscription], [billing_thresholds], [price], [tax_rates], [created], [metadata],
    content=[subscription_items]
);
CREATE VIRTUAL TABLE [subscription_schedules_fts] USING FTS5 (
    [id], [customer], [subscription], [canceled_at], [completed_at], [current_phase], [default_settings], [end_behavior], [phases], [released_at], [released_subscription], [status], [created], [metadata],
    content=[subscription_schedules]
);
CREATE VIRTUAL TABLE [subscriptions_fts] USING FTS5 (
    [id], [customer], [default_payment_method], [default_source], [latest_invoice], [pending_setup_intent], [schedule], [billing_cycle_anchor], [billing_thresholds], [cancel_at], [canceled_at], [collection_method], [current_period_end], [current_period_start], [default_tax_rates], [discount], [ended_at], [items], [next_pending_invoice_item_invoice], [pause_collection], [pending_invoice_item_interval], [pending_update], [start_date], [status], [transfer_data], [trial_end], [trial_start], [created], [metadata],
    content=[subscriptions]
);
CREATE VIRTUAL TABLE [tax_ids_fts] USING FTS5 (
    [id], [type], [customer], [country], [value], [verification], [created],
    content=[tax_ids]
);
CREATE VIRTUAL TABLE [tax_rates_fts] USING FTS5 (
    [id], [description], [display_name], [jurisdiction], [created], [metadata],
    content=[tax_rates]
);
CREATE VIRTUAL TABLE [td_metadata_fts] USING FTS5 (
    [cli_version], [stripe_version], [stripe_account_id], [stripe_account],
    content=[td_metadata]
);


INSERT INTO
  [balance_transactions_fts] (
    rowid,
    [id],
    [type],
    [source],
    [available_on],
    [currency],
    [description],
    [fee_details],
    [reporting_category],
    [status],
    [created]
  )
SELECT
  rowid,
  [id],
  [type],
  [source],
  [available_on],
  [currency],
  [description],
  [fee_details],
  [reporting_category],
  [status],
  [created]
FROM
  [balance_transactions];
INSERT INTO
  [bank_accounts_fts] (
    rowid,
    [id],
    [account],
    [customer],
    [account_holder_name],
    [account_holder_type],
    [available_payout_methods],
    [bank_name],
    [country],
    [currency],
    [fingerprint],
    [last4],
    [routing_number],
    [status]
  )
SELECT
  rowid,
  [id],
  [account],
  [customer],
  [account_holder_name],
  [account_holder_type],
  [available_payout_methods],
  [bank_name],
  [country],
  [currency],
  [fingerprint],
  [last4],
  [routing_number],
  [status]
FROM
  [bank_accounts];
INSERT INTO
  [cards_fts] (
    rowid,
    [id],
    [name],
    [account],
    [customer],
    [recipient],
    [address_city],
    [address_country],
    [address_line1],
    [address_line1_check],
    [address_line2],
    [address_state],
    [address_zip],
    [address_zip_check],
    [available_payout_methods],
    [brand],
    [country],
    [currency],
    [cvc_check],
    [dynamic_last4],
    [fingerprint],
    [funding],
    [last4],
    [tokenization_method],
    [metadata]
  )
SELECT
  rowid,
  [id],
  [name],
  [account],
  [customer],
  [recipient],
  [address_city],
  [address_country],
  [address_line1],
  [address_line1_check],
  [address_line2],
  [address_state],
  [address_zip],
  [address_zip_check],
  [available_payout_methods],
  [brand],
  [country],
  [currency],
  [cvc_check],
  [dynamic_last4],
  [fingerprint],
  [funding],
  [last4],
  [tokenization_method],
  [metadata]
FROM
  [cards];
INSERT INTO
  [charges_fts] (
    rowid,
    [id],
    [application],
    [application_fee],
    [balance_transaction],
    [customer],
    [invoice],
    [on_behalf_of],
    [order_id],
    [payment_intent],
    [review],
    [source_transfer],
    [transfer],
    [billing_details],
    [calculated_statement_descriptor],
    [currency],
    [description],
    [failure_code],
    [failure_message],
    [fraud_details],
    [outcome],
    [payment_method],
    [payment_method_details],
    [payment_method_details_type],
    [receipt_email],
    [receipt_number],
    [receipt_url],
    [refunds],
    [shipping],
    [statement_descriptor],
    [statement_descriptor_suffix],
    [status],
    [transfer_data],
    [transfer_group],
    [created],
    [metadata]
  )
SELECT
  rowid,
  [id],
  [application],
  [application_fee],
  [balance_transaction],
  [customer],
  [invoice],
  [on_behalf_of],
  [order_id],
  [payment_intent],
  [review],
  [source_transfer],
  [transfer],
  [billing_details],
  [calculated_statement_descriptor],
  [currency],
  [description],
  [failure_code],
  [failure_message],
  [fraud_details],
  [outcome],
  [payment_method],
  [payment_method_details],
  [payment_method_details_type],
  [receipt_email],
  [receipt_number],
  [receipt_url],
  [refunds],
  [shipping],
  [statement_descriptor],
  [statement_descriptor_suffix],
  [status],
  [transfer_data],
  [transfer_group],
  [created],
  [metadata]
FROM
  [charges];
INSERT INTO
  [coupons_fts] (
    rowid,
    [id],
    [name],
    [applies_to],
    [currency],
    [duration],
    [metadata]
  )
SELECT
  rowid,
  [id],
  [name],
  [applies_to],
  [currency],
  [duration],
  [metadata]
FROM
  [coupons];
INSERT INTO
  [credit_note_line_items_fts] (
    rowid,
    [id],
    [type],
    [credit_note_id],
    [description],
    [discount_amounts],
    [invoice_line_item],
    [tax_amounts],
    [tax_rates],
    [unit_amount_decimal]
  )
SELECT
  rowid,
  [id],
  [type],
  [credit_note_id],
  [description],
  [discount_amounts],
  [invoice_line_item],
  [tax_amounts],
  [tax_rates],
  [unit_amount_decimal]
FROM
  [credit_note_line_items];
INSERT INTO
  [credit_notes_fts] (
    rowid,
    [id],
    [type],
    [customer],
    [customer_balance_transaction],
    [invoice],
    [refund],
    [currency],
    [discount_amounts],
    [lines_first_x],
    [memo],
    [number],
    [pdf],
    [reason],
    [status],
    [tax_amounts],
    [voided_at],
    [created],
    [metadata]
  )
SELECT
  rowid,
  [id],
  [type],
  [customer],
  [customer_balance_transaction],
  [invoice],
  [refund],
  [currency],
  [discount_amounts],
  [lines_first_x],
  [memo],
  [number],
  [pdf],
  [reason],
  [status],
  [tax_amounts],
  [voided_at],
  [created],
  [metadata]
FROM
  [credit_notes];
INSERT INTO
  [customers_fts] (
    rowid,
    [id],
    [name],
    [email],
    [default_source],
    [address],
    [shipping],
    [currency],
    [description],
    [discount],
    [invoice_prefix],
    [invoice_settings],
    [phone],
    [preferred_locales],
    [tax_exempt],
    [created],
    [metadata]
  )
SELECT
  rowid,
  [id],
  [name],
  [email],
  [default_source],
  [address],
  [shipping],
  [currency],
  [description],
  [discount],
  [invoice_prefix],
  [invoice_settings],
  [phone],
  [preferred_locales],
  [tax_exempt],
  [created],
  [metadata]
FROM
  [customers];
INSERT INTO
  [discounts_fts] (
    rowid,
    [id],
    [coupon],
    [customer],
    [subscription],
    [invoice],
    [invoice_item],
    [promotion_code],
    [checkout_session],
    [start],
    [end_ts]
  )
SELECT
  rowid,
  [id],
  [coupon],
  [customer],
  [subscription],
  [invoice],
  [invoice_item],
  [promotion_code],
  [checkout_session],
  [start],
  [end_ts]
FROM
  [discounts];
INSERT INTO
  [disputes_fts] (
    rowid,
    [id],
    [charge],
    [payment_intent],
    [balance_transactions],
    [currency],
    [evidence],
    [evidence_details],
    [reason],
    [status],
    [created],
    [metadata]
  )
SELECT
  rowid,
  [id],
  [charge],
  [payment_intent],
  [balance_transactions],
  [currency],
  [evidence],
  [evidence_details],
  [reason],
  [status],
  [created],
  [metadata]
FROM
  [disputes];
INSERT INTO
  [invoice_line_items_fts] (
    rowid,
    [id],
    [type],
    [invoice],
    [invoice_item],
    [subscription],
    [subscription_item],
    [discounts],
    [currency],
    [description],
    [discount_amounts],
    [period_json],
    [price],
    [tax_amounts],
    [tax_rates],
    [metadata]
  )
SELECT
  rowid,
  [id],
  [type],
  [invoice],
  [invoice_item],
  [subscription],
  [subscription_item],
  [discounts],
  [currency],
  [description],
  [discount_amounts],
  [period_json],
  [price],
  [tax_amounts],
  [tax_rates],
  [metadata]
FROM
  [invoice_line_items];
INSERT INTO
  [invoiceitems_fts] (
    rowid,
    [id],
    [customer],
    [invoice],
    [subscription],
    [subscription_item],
    [discounts],
    [currency],
    [date_ts],
    [description],
    [period_json],
    [price],
    [tax_rates],
    [unit_amount_decimal],
    [metadata]
  )
SELECT
  rowid,
  [id],
  [customer],
  [invoice],
  [subscription],
  [subscription_item],
  [discounts],
  [currency],
  [date_ts],
  [description],
  [period_json],
  [price],
  [tax_rates],
  [unit_amount_decimal],
  [metadata]
FROM
  [invoiceitems];
INSERT INTO
  [invoices_fts] (
    rowid,
    [id],
    [charge],
    [customer],
    [default_payment_method],
    [default_source],
    [discounts],
    [payment_intent],
    [subscription],
    [account_country],
    [account_name],
    [billing_reason],
    [collection_method],
    [currency],
    [custom_fields],
    [customer_address],
    [customer_email],
    [customer_name],
    [customer_phone],
    [customer_shipping],
    [customer_tax_exempt],
    [customer_tax_ids],
    [default_tax_rates],
    [description],
    [due_date],
    [footer],
    [hosted_invoice_url],
    [invoice_pdf],
    [last_finalization_error],
    [lines_newest_10],
    [next_payment_attempt],
    [number],
    [period_end],
    [period_start],
    [receipt_number],
    [statement_descriptor],
    [status],
    [status_transitions],
    [threshold_reason],
    [total_discount_amounts],
    [total_tax_amounts],
    [transfer_data],
    [webhooks_delivered_at],
    [created],
    [metadata]
  )
SELECT
  rowid,
  [id],
  [charge],
  [customer],
  [default_payment_method],
  [default_source],
  [discounts],
  [payment_intent],
  [subscription],
  [account_country],
  [account_name],
  [billing_reason],
  [collection_method],
  [currency],
  [custom_fields],
  [customer_address],
  [customer_email],
  [customer_name],
  [customer_phone],
  [customer_shipping],
  [customer_tax_exempt],
  [customer_tax_ids],
  [default_tax_rates],
  [description],
  [due_date],
  [footer],
  [hosted_invoice_url],
  [invoice_pdf],
  [last_finalization_error],
  [lines_newest_10],
  [next_payment_attempt],
  [number],
  [period_end],
  [period_start],
  [receipt_number],
  [statement_descriptor],
  [status],
  [status_transitions],
  [threshold_reason],
  [total_discount_amounts],
  [total_tax_amounts],
  [transfer_data],
  [webhooks_delivered_at],
  [created],
  [metadata]
FROM
  [invoices];
INSERT INTO
  [notification_events_fts] (
    rowid,
    [id],
    [type],
    [resource],
    [action],
    [account],
    [api_version],
    [data_object_id],
    [data_object_object],
    [data_object],
    [data_previous_attributes],
    [request_id],
    [request_idempotency_key],
    [created]
  )
SELECT
  rowid,
  [id],
  [type],
  [resource],
  [action],
  [account],
  [api_version],
  [data_object_id],
  [data_object_object],
  [data_object],
  [data_previous_attributes],
  [request_id],
  [request_idempotency_key],
  [created]
FROM
  [notification_events];
INSERT INTO
  [order_returns_fts] (
    rowid,
    [id],
    [order_id],
    [refund],
    [currency],
    [items],
    [created]
  )
SELECT
  rowid,
  [id],
  [order_id],
  [refund],
  [currency],
  [items],
  [created]
FROM
  [order_returns];
INSERT INTO
  [orders_fts] (
    rowid,
    [id],
    [upstream_id],
    [charge],
    [customer],
    [application],
    [currency],
    [email],
    [external_coupon_code],
    [items],
    [returns],
    [selected_shipping_method],
    [shipping],
    [shipping_methods],
    [status],
    [status_transitions],
    [created],
    [updated],
    [metadata]
  )
SELECT
  rowid,
  [id],
  [upstream_id],
  [charge],
  [customer],
  [application],
  [currency],
  [email],
  [external_coupon_code],
  [items],
  [returns],
  [selected_shipping_method],
  [shipping],
  [shipping_methods],
  [status],
  [status_transitions],
  [created],
  [updated],
  [metadata]
FROM
  [orders];
INSERT INTO
  [payment_intents_fts] (
    rowid,
    [id],
    [application],
    [customer],
    [invoice],
    [on_behalf_of],
    [payment_method],
    [review],
    [canceled_at],
    [cancellation_reason],
    [capture_method],
    [client_secret],
    [confirmation_method],
    [currency],
    [description],
    [last_payment_error],
    [next_action],
    [payment_method_options],
    [payment_method_types],
    [receipt_email],
    [setup_future_usage],
    [shipping],
    [statement_descriptor],
    [statement_descriptor_suffix],
    [status],
    [transfer_data_destination],
    [transfer_group],
    [created],
    [metadata]
  )
SELECT
  rowid,
  [id],
  [application],
  [customer],
  [invoice],
  [on_behalf_of],
  [payment_method],
  [review],
  [canceled_at],
  [cancellation_reason],
  [capture_method],
  [client_secret],
  [confirmation_method],
  [currency],
  [description],
  [last_payment_error],
  [next_action],
  [payment_method_options],
  [payment_method_types],
  [receipt_email],
  [setup_future_usage],
  [shipping],
  [statement_descriptor],
  [statement_descriptor_suffix],
  [status],
  [transfer_data_destination],
  [transfer_group],
  [created],
  [metadata]
FROM
  [payment_intents];
INSERT INTO
  [payment_methods_fts] (
    rowid,
    [type],
    [id],
    [customer],
    [alipay],
    [au_becs_debit],
    [bacs_debit],
    [bancontact],
    [billing_details],
    [card],
    [card_present],
    [eps],
    [fpx],
    [giropay],
    [grabpay],
    [ideal],
    [interac_present],
    [oxxo],
    [p24],
    [sepa_debit],
    [sofort],
    [created],
    [metadata]
  )
SELECT
  rowid,
  [type],
  [id],
  [customer],
  [alipay],
  [au_becs_debit],
  [bacs_debit],
  [bancontact],
  [billing_details],
  [card],
  [card_present],
  [eps],
  [fpx],
  [giropay],
  [grabpay],
  [ideal],
  [interac_present],
  [oxxo],
  [p24],
  [sepa_debit],
  [sofort],
  [created],
  [metadata]
FROM
  [payment_methods];
INSERT INTO
  [prices_fts] (
    rowid,
    [id],
    [type],
    [product],
    [billing_scheme],
    [currency],
    [lookup_key],
    [nickname],
    [recurring],
    [tiers],
    [tiers_mode],
    [transform_quantity],
    [unit_amount_decimal],
    [created],
    [metadata]
  )
SELECT
  rowid,
  [id],
  [type],
  [product],
  [billing_scheme],
  [currency],
  [lookup_key],
  [nickname],
  [recurring],
  [tiers],
  [tiers_mode],
  [transform_quantity],
  [unit_amount_decimal],
  [created],
  [metadata]
FROM
  [prices];
INSERT INTO
  [products_fts] (
    rowid,
    [id],
    [type],
    [name],
    [attributes],
    [caption],
    [deactivate_on],
    [description],
    [images],
    [package_dimensions],
    [statement_descriptor],
    [unit_label],
    [url],
    [updated],
    [created],
    [metadata]
  )
SELECT
  rowid,
  [id],
  [type],
  [name],
  [attributes],
  [caption],
  [deactivate_on],
  [description],
  [images],
  [package_dimensions],
  [statement_descriptor],
  [unit_label],
  [url],
  [updated],
  [created],
  [metadata]
FROM
  [products];
INSERT INTO
  [promotion_codes_fts] (
    rowid,
    [id],
    [customer],
    [code],
    [coupon],
    [expires_at],
    [restrictions],
    [created],
    [metadata]
  )
SELECT
  rowid,
  [id],
  [customer],
  [code],
  [coupon],
  [expires_at],
  [restrictions],
  [created],
  [metadata]
FROM
  [promotion_codes];
INSERT INTO
  [refunds_fts] (
    rowid,
    [id],
    [balance_transaction],
    [charge],
    [failure_balance_transaction],
    [payment_intent],
    [source_transfer_reversal],
    [transfer_reversal],
    [currency],
    [description],
    [failure_reason],
    [reason],
    [receipt_number],
    [status],
    [created],
    [metadata]
  )
SELECT
  rowid,
  [id],
  [balance_transaction],
  [charge],
  [failure_balance_transaction],
  [payment_intent],
  [source_transfer_reversal],
  [transfer_reversal],
  [currency],
  [description],
  [failure_reason],
  [reason],
  [receipt_number],
  [status],
  [created],
  [metadata]
FROM
  [refunds];
INSERT INTO
  [setup_intents_fts] (
    rowid,
    [id],
    [application],
    [customer],
    [latest_attempt],
    [mandate],
    [on_behalf_of],
    [payment_method],
    [single_use_mandate],
    [cancellation_reason],
    [client_secret],
    [description],
    [last_setup_error],
    [next_action],
    [payment_method_options],
    [payment_method_types],
    [status],
    [usage_x],
    [created],
    [metadata]
  )
SELECT
  rowid,
  [id],
  [application],
  [customer],
  [latest_attempt],
  [mandate],
  [on_behalf_of],
  [payment_method],
  [single_use_mandate],
  [cancellation_reason],
  [client_secret],
  [description],
  [last_setup_error],
  [next_action],
  [payment_method_options],
  [payment_method_types],
  [status],
  [usage_x],
  [created],
  [metadata]
FROM
  [setup_intents];
INSERT INTO
  [skus_fts] (
    rowid,
    [id],
    [product],
    [attributes],
    [currency],
    [image],
    [inventory],
    [package_dimensions],
    [created],
    [updated],
    [metadata]
  )
SELECT
  rowid,
  [id],
  [product],
  [attributes],
  [currency],
  [image],
  [inventory],
  [package_dimensions],
  [created],
  [updated],
  [metadata]
FROM
  [skus];
INSERT INTO
  [sources_fts] (
    rowid,
    [id],
    [type],
    [customer],
    [ach_credit_transfer],
    [ach_debit],
    [alipay],
    [au_becs_debit],
    [bancontact],
    [card],
    [card_present],
    [client_secret],
    [code_verification],
    [currency],
    [eps],
    [flow],
    [giropay],
    [ideal],
    [klarna],
    [multibanco],
    [owner],
    [p24],
    [receiver],
    [redirect],
    [sepa_debit],
    [sofort],
    [source_order],
    [statement_descriptor],
    [status],
    [three_d_secure],
    [usage_x],
    [wechat],
    [created],
    [metadata]
  )
SELECT
  rowid,
  [id],
  [type],
  [customer],
  [ach_credit_transfer],
  [ach_debit],
  [alipay],
  [au_becs_debit],
  [bancontact],
  [card],
  [card_present],
  [client_secret],
  [code_verification],
  [currency],
  [eps],
  [flow],
  [giropay],
  [ideal],
  [klarna],
  [multibanco],
  [owner],
  [p24],
  [receiver],
  [redirect],
  [sepa_debit],
  [sofort],
  [source_order],
  [statement_descriptor],
  [status],
  [three_d_secure],
  [usage_x],
  [wechat],
  [created],
  [metadata]
FROM
  [sources];
INSERT INTO
  [subscription_items_fts] (
    rowid,
    [id],
    [subscription],
    [billing_thresholds],
    [price],
    [tax_rates],
    [created],
    [metadata]
  )
SELECT
  rowid,
  [id],
  [subscription],
  [billing_thresholds],
  [price],
  [tax_rates],
  [created],
  [metadata]
FROM
  [subscription_items];
INSERT INTO
  [subscription_schedules_fts] (
    rowid,
    [id],
    [customer],
    [subscription],
    [canceled_at],
    [completed_at],
    [current_phase],
    [default_settings],
    [end_behavior],
    [phases],
    [released_at],
    [released_subscription],
    [status],
    [created],
    [metadata]
  )
SELECT
  rowid,
  [id],
  [customer],
  [subscription],
  [canceled_at],
  [completed_at],
  [current_phase],
  [default_settings],
  [end_behavior],
  [phases],
  [released_at],
  [released_subscription],
  [status],
  [created],
  [metadata]
FROM
  [subscription_schedules];
INSERT INTO
  [subscriptions_fts] (
    rowid,
    [id],
    [customer],
    [default_payment_method],
    [default_source],
    [latest_invoice],
    [pending_setup_intent],
    [schedule],
    [billing_cycle_anchor],
    [billing_thresholds],
    [cancel_at],
    [canceled_at],
    [collection_method],
    [current_period_end],
    [current_period_start],
    [default_tax_rates],
    [discount],
    [ended_at],
    [items],
    [next_pending_invoice_item_invoice],
    [pause_collection],
    [pending_invoice_item_interval],
    [pending_update],
    [start_date],
    [status],
    [transfer_data],
    [trial_end],
    [trial_start],
    [created],
    [metadata]
  )
SELECT
  rowid,
  [id],
  [customer],
  [default_payment_method],
  [default_source],
  [latest_invoice],
  [pending_setup_intent],
  [schedule],
  [billing_cycle_anchor],
  [billing_thresholds],
  [cancel_at],
  [canceled_at],
  [collection_method],
  [current_period_end],
  [current_period_start],
  [default_tax_rates],
  [discount],
  [ended_at],
  [items],
  [next_pending_invoice_item_invoice],
  [pause_collection],
  [pending_invoice_item_interval],
  [pending_update],
  [start_date],
  [status],
  [transfer_data],
  [trial_end],
  [trial_start],
  [created],
  [metadata]
FROM
  [subscriptions];
INSERT INTO
  [tax_ids_fts] (
    rowid,
    [id],
    [type],
    [customer],
    [country],
    [value],
    [verification],
    [created]
  )
SELECT
  rowid,
  [id],
  [type],
  [customer],
  [country],
  [value],
  [verification],
  [created]
FROM
  [tax_ids];
INSERT INTO
  [tax_rates_fts] (
    rowid,
    [id],
    [description],
    [display_name],
    [jurisdiction],
    [created],
    [metadata]
  )
SELECT
  rowid,
  [id],
  [description],
  [display_name],
  [jurisdiction],
  [created],
  [metadata]
FROM
  [tax_rates];
INSERT INTO
  [td_metadata_fts] (
    rowid,
    [cli_version],
    [stripe_version],
    [stripe_account_id],
    [stripe_account]
  )
SELECT
  rowid,
  [cli_version],
  [stripe_version],
  [stripe_account_id],
  [stripe_account]
FROM
  [td_metadata];


CREATE VIRTUAL TABLE [td_stripe_apply_events_fts] USING FTS5 (
    [event_id], [action], [write_ids],
    content=[td_stripe_apply_events]
);
CREATE VIRTUAL TABLE [td_stripe_writes_fts] USING FTS5 (
    [obj_type], [obj_id], [table_name], [write_type],
    content=[td_stripe_writes]
);
CREATE TRIGGER [td_stripe_apply_events_ai] AFTER INSERT ON [td_stripe_apply_events] BEGIN
  INSERT INTO [td_stripe_apply_events_fts] (rowid, [event_id], [action], [write_ids]) VALUES (new.rowid, new.[event_id], new.[action], new.[write_ids]);
END;
CREATE TRIGGER [td_stripe_apply_events_ad] AFTER DELETE ON [td_stripe_apply_events] BEGIN
  INSERT INTO [td_stripe_apply_events_fts] ([td_stripe_apply_events_fts], rowid, [event_id], [action], [write_ids]) VALUES('delete', old.rowid, old.[event_id], old.[action], old.[write_ids]);
END;
CREATE TRIGGER [td_stripe_apply_events_au] AFTER UPDATE ON [td_stripe_apply_events] BEGIN
  INSERT INTO [td_stripe_apply_events_fts] ([td_stripe_apply_events_fts], rowid, [event_id], [action], [write_ids]) VALUES('delete', old.rowid, old.[event_id], old.[action], old.[write_ids]);
  INSERT INTO [td_stripe_apply_events_fts] (rowid, [event_id], [action], [write_ids]) VALUES (new.rowid, new.[event_id], new.[action], new.[write_ids]);
END;
CREATE TRIGGER [td_stripe_writes_ai] AFTER INSERT ON [td_stripe_writes] BEGIN
  INSERT INTO [td_stripe_writes_fts] (rowid, [obj_type], [obj_id], [table_name], [write_type]) VALUES (new.rowid, new.[obj_type], new.[obj_id], new.[table_name], new.[write_type]);
END;
CREATE TRIGGER [td_stripe_writes_ad] AFTER DELETE ON [td_stripe_writes] BEGIN
  INSERT INTO [td_stripe_writes_fts] ([td_stripe_writes_fts], rowid, [obj_type], [obj_id], [table_name], [write_type]) VALUES('delete', old.rowid, old.[obj_type], old.[obj_id], old.[table_name], old.[write_type]);
END;
CREATE TRIGGER [td_stripe_writes_au] AFTER UPDATE ON [td_stripe_writes] BEGIN
  INSERT INTO [td_stripe_writes_fts] ([td_stripe_writes_fts], rowid, [obj_type], [obj_id], [table_name], [write_type]) VALUES('delete', old.rowid, old.[obj_type], old.[obj_id], old.[table_name], old.[write_type]);
  INSERT INTO [td_stripe_writes_fts] (rowid, [obj_type], [obj_id], [table_name], [write_type]) VALUES (new.rowid, new.[obj_type], new.[obj_id], new.[table_name], new.[write_type]);
END;
CREATE TRIGGER [td_metadata_ai] AFTER INSERT ON [td_metadata] BEGIN
  INSERT INTO [td_metadata_fts] (rowid, [cli_version], [stripe_version], [stripe_account_id], [stripe_account]) VALUES (new.rowid, new.[cli_version], new.[stripe_version], new.[stripe_account_id], new.[stripe_account]);
END;
CREATE TRIGGER [td_metadata_ad] AFTER DELETE ON [td_metadata] BEGIN
  INSERT INTO [td_metadata_fts] ([td_metadata_fts], rowid, [cli_version], [stripe_version], [stripe_account_id], [stripe_account]) VALUES('delete', old.rowid, old.[cli_version], old.[stripe_version], old.[stripe_account_id], old.[stripe_account]);
END;
CREATE TRIGGER [td_metadata_au] AFTER UPDATE ON [td_metadata] BEGIN
  INSERT INTO [td_metadata_fts] ([td_metadata_fts], rowid, [cli_version], [stripe_version], [stripe_account_id], [stripe_account]) VALUES('delete', old.rowid, old.[cli_version], old.[stripe_version], old.[stripe_account_id], old.[stripe_account]);
  INSERT INTO [td_metadata_fts] (rowid, [cli_version], [stripe_version], [stripe_account_id], [stripe_account]) VALUES (new.rowid, new.[cli_version], new.[stripe_version], new.[stripe_account_id], new.[stripe_account]);
END;
CREATE TRIGGER [balance_transactions_ai] AFTER INSERT ON [balance_transactions] BEGIN
  INSERT INTO [balance_transactions_fts] (rowid, [id], [type], [source], [available_on], [currency], [description], [fee_details], [reporting_category], [status], [created]) VALUES (new.rowid, new.[id], new.[type], new.[source], new.[available_on], new.[currency], new.[description], new.[fee_details], new.[reporting_category], new.[status], new.[created]);
END;
CREATE TRIGGER [balance_transactions_ad] AFTER DELETE ON [balance_transactions] BEGIN
  INSERT INTO [balance_transactions_fts] ([balance_transactions_fts], rowid, [id], [type], [source], [available_on], [currency], [description], [fee_details], [reporting_category], [status], [created]) VALUES('delete', old.rowid, old.[id], old.[type], old.[source], old.[available_on], old.[currency], old.[description], old.[fee_details], old.[reporting_category], old.[status], old.[created]);
END;
CREATE TRIGGER [balance_transactions_au] AFTER UPDATE ON [balance_transactions] BEGIN
  INSERT INTO [balance_transactions_fts] ([balance_transactions_fts], rowid, [id], [type], [source], [available_on], [currency], [description], [fee_details], [reporting_category], [status], [created]) VALUES('delete', old.rowid, old.[id], old.[type], old.[source], old.[available_on], old.[currency], old.[description], old.[fee_details], old.[reporting_category], old.[status], old.[created]);
  INSERT INTO [balance_transactions_fts] (rowid, [id], [type], [source], [available_on], [currency], [description], [fee_details], [reporting_category], [status], [created]) VALUES (new.rowid, new.[id], new.[type], new.[source], new.[available_on], new.[currency], new.[description], new.[fee_details], new.[reporting_category], new.[status], new.[created]);
END;
CREATE TRIGGER [bank_accounts_ai] AFTER INSERT ON [bank_accounts] BEGIN
  INSERT INTO [bank_accounts_fts] (rowid, [id], [account], [customer], [account_holder_name], [account_holder_type], [available_payout_methods], [bank_name], [country], [currency], [fingerprint], [last4], [routing_number], [status]) VALUES (new.rowid, new.[id], new.[account], new.[customer], new.[account_holder_name], new.[account_holder_type], new.[available_payout_methods], new.[bank_name], new.[country], new.[currency], new.[fingerprint], new.[last4], new.[routing_number], new.[status]);
END;
CREATE TRIGGER [bank_accounts_ad] AFTER DELETE ON [bank_accounts] BEGIN
  INSERT INTO [bank_accounts_fts] ([bank_accounts_fts], rowid, [id], [account], [customer], [account_holder_name], [account_holder_type], [available_payout_methods], [bank_name], [country], [currency], [fingerprint], [last4], [routing_number], [status]) VALUES('delete', old.rowid, old.[id], old.[account], old.[customer], old.[account_holder_name], old.[account_holder_type], old.[available_payout_methods], old.[bank_name], old.[country], old.[currency], old.[fingerprint], old.[last4], old.[routing_number], old.[status]);
END;
CREATE TRIGGER [bank_accounts_au] AFTER UPDATE ON [bank_accounts] BEGIN
  INSERT INTO [bank_accounts_fts] ([bank_accounts_fts], rowid, [id], [account], [customer], [account_holder_name], [account_holder_type], [available_payout_methods], [bank_name], [country], [currency], [fingerprint], [last4], [routing_number], [status]) VALUES('delete', old.rowid, old.[id], old.[account], old.[customer], old.[account_holder_name], old.[account_holder_type], old.[available_payout_methods], old.[bank_name], old.[country], old.[currency], old.[fingerprint], old.[last4], old.[routing_number], old.[status]);
  INSERT INTO [bank_accounts_fts] (rowid, [id], [account], [customer], [account_holder_name], [account_holder_type], [available_payout_methods], [bank_name], [country], [currency], [fingerprint], [last4], [routing_number], [status]) VALUES (new.rowid, new.[id], new.[account], new.[customer], new.[account_holder_name], new.[account_holder_type], new.[available_payout_methods], new.[bank_name], new.[country], new.[currency], new.[fingerprint], new.[last4], new.[routing_number], new.[status]);
END;
CREATE TRIGGER [cards_ai] AFTER INSERT ON [cards] BEGIN
  INSERT INTO [cards_fts] (rowid, [id], [name], [account], [customer], [recipient], [address_city], [address_country], [address_line1], [address_line1_check], [address_line2], [address_state], [address_zip], [address_zip_check], [available_payout_methods], [brand], [country], [currency], [cvc_check], [dynamic_last4], [fingerprint], [funding], [last4], [tokenization_method], [metadata]) VALUES (new.rowid, new.[id], new.[name], new.[account], new.[customer], new.[recipient], new.[address_city], new.[address_country], new.[address_line1], new.[address_line1_check], new.[address_line2], new.[address_state], new.[address_zip], new.[address_zip_check], new.[available_payout_methods], new.[brand], new.[country], new.[currency], new.[cvc_check], new.[dynamic_last4], new.[fingerprint], new.[funding], new.[last4], new.[tokenization_method], new.[metadata]);
END;
CREATE TRIGGER [cards_ad] AFTER DELETE ON [cards] BEGIN
  INSERT INTO [cards_fts] ([cards_fts], rowid, [id], [name], [account], [customer], [recipient], [address_city], [address_country], [address_line1], [address_line1_check], [address_line2], [address_state], [address_zip], [address_zip_check], [available_payout_methods], [brand], [country], [currency], [cvc_check], [dynamic_last4], [fingerprint], [funding], [last4], [tokenization_method], [metadata]) VALUES('delete', old.rowid, old.[id], old.[name], old.[account], old.[customer], old.[recipient], old.[address_city], old.[address_country], old.[address_line1], old.[address_line1_check], old.[address_line2], old.[address_state], old.[address_zip], old.[address_zip_check], old.[available_payout_methods], old.[brand], old.[country], old.[currency], old.[cvc_check], old.[dynamic_last4], old.[fingerprint], old.[funding], old.[last4], old.[tokenization_method], old.[metadata]);
END;
CREATE TRIGGER [cards_au] AFTER UPDATE ON [cards] BEGIN
  INSERT INTO [cards_fts] ([cards_fts], rowid, [id], [name], [account], [customer], [recipient], [address_city], [address_country], [address_line1], [address_line1_check], [address_line2], [address_state], [address_zip], [address_zip_check], [available_payout_methods], [brand], [country], [currency], [cvc_check], [dynamic_last4], [fingerprint], [funding], [last4], [tokenization_method], [metadata]) VALUES('delete', old.rowid, old.[id], old.[name], old.[account], old.[customer], old.[recipient], old.[address_city], old.[address_country], old.[address_line1], old.[address_line1_check], old.[address_line2], old.[address_state], old.[address_zip], old.[address_zip_check], old.[available_payout_methods], old.[brand], old.[country], old.[currency], old.[cvc_check], old.[dynamic_last4], old.[fingerprint], old.[funding], old.[last4], old.[tokenization_method], old.[metadata]);
  INSERT INTO [cards_fts] (rowid, [id], [name], [account], [customer], [recipient], [address_city], [address_country], [address_line1], [address_line1_check], [address_line2], [address_state], [address_zip], [address_zip_check], [available_payout_methods], [brand], [country], [currency], [cvc_check], [dynamic_last4], [fingerprint], [funding], [last4], [tokenization_method], [metadata]) VALUES (new.rowid, new.[id], new.[name], new.[account], new.[customer], new.[recipient], new.[address_city], new.[address_country], new.[address_line1], new.[address_line1_check], new.[address_line2], new.[address_state], new.[address_zip], new.[address_zip_check], new.[available_payout_methods], new.[brand], new.[country], new.[currency], new.[cvc_check], new.[dynamic_last4], new.[fingerprint], new.[funding], new.[last4], new.[tokenization_method], new.[metadata]);
END;
CREATE TRIGGER [charges_ai] AFTER INSERT ON [charges] BEGIN
  INSERT INTO [charges_fts] (rowid, [id], [application], [application_fee], [balance_transaction], [customer], [invoice], [on_behalf_of], [order_id], [payment_intent], [review], [source_transfer], [transfer], [billing_details], [calculated_statement_descriptor], [currency], [description], [failure_code], [failure_message], [fraud_details], [outcome], [payment_method], [payment_method_details], [payment_method_details_type], [receipt_email], [receipt_number], [receipt_url], [refunds], [shipping], [statement_descriptor], [statement_descriptor_suffix], [status], [transfer_data], [transfer_group], [created], [metadata]) VALUES (new.rowid, new.[id], new.[application], new.[application_fee], new.[balance_transaction], new.[customer], new.[invoice], new.[on_behalf_of], new.[order_id], new.[payment_intent], new.[review], new.[source_transfer], new.[transfer], new.[billing_details], new.[calculated_statement_descriptor], new.[currency], new.[description], new.[failure_code], new.[failure_message], new.[fraud_details], new.[outcome], new.[payment_method], new.[payment_method_details], new.[payment_method_details_type], new.[receipt_email], new.[receipt_number], new.[receipt_url], new.[refunds], new.[shipping], new.[statement_descriptor], new.[statement_descriptor_suffix], new.[status], new.[transfer_data], new.[transfer_group], new.[created], new.[metadata]);
END;
CREATE TRIGGER [charges_ad] AFTER DELETE ON [charges] BEGIN
  INSERT INTO [charges_fts] ([charges_fts], rowid, [id], [application], [application_fee], [balance_transaction], [customer], [invoice], [on_behalf_of], [order_id], [payment_intent], [review], [source_transfer], [transfer], [billing_details], [calculated_statement_descriptor], [currency], [description], [failure_code], [failure_message], [fraud_details], [outcome], [payment_method], [payment_method_details], [payment_method_details_type], [receipt_email], [receipt_number], [receipt_url], [refunds], [shipping], [statement_descriptor], [statement_descriptor_suffix], [status], [transfer_data], [transfer_group], [created], [metadata]) VALUES('delete', old.rowid, old.[id], old.[application], old.[application_fee], old.[balance_transaction], old.[customer], old.[invoice], old.[on_behalf_of], old.[order_id], old.[payment_intent], old.[review], old.[source_transfer], old.[transfer], old.[billing_details], old.[calculated_statement_descriptor], old.[currency], old.[description], old.[failure_code], old.[failure_message], old.[fraud_details], old.[outcome], old.[payment_method], old.[payment_method_details], old.[payment_method_details_type], old.[receipt_email], old.[receipt_number], old.[receipt_url], old.[refunds], old.[shipping], old.[statement_descriptor], old.[statement_descriptor_suffix], old.[status], old.[transfer_data], old.[transfer_group], old.[created], old.[metadata]);
END;
CREATE TRIGGER [charges_au] AFTER UPDATE ON [charges] BEGIN
  INSERT INTO [charges_fts] ([charges_fts], rowid, [id], [application], [application_fee], [balance_transaction], [customer], [invoice], [on_behalf_of], [order_id], [payment_intent], [review], [source_transfer], [transfer], [billing_details], [calculated_statement_descriptor], [currency], [description], [failure_code], [failure_message], [fraud_details], [outcome], [payment_method], [payment_method_details], [payment_method_details_type], [receipt_email], [receipt_number], [receipt_url], [refunds], [shipping], [statement_descriptor], [statement_descriptor_suffix], [status], [transfer_data], [transfer_group], [created], [metadata]) VALUES('delete', old.rowid, old.[id], old.[application], old.[application_fee], old.[balance_transaction], old.[customer], old.[invoice], old.[on_behalf_of], old.[order_id], old.[payment_intent], old.[review], old.[source_transfer], old.[transfer], old.[billing_details], old.[calculated_statement_descriptor], old.[currency], old.[description], old.[failure_code], old.[failure_message], old.[fraud_details], old.[outcome], old.[payment_method], old.[payment_method_details], old.[payment_method_details_type], old.[receipt_email], old.[receipt_number], old.[receipt_url], old.[refunds], old.[shipping], old.[statement_descriptor], old.[statement_descriptor_suffix], old.[status], old.[transfer_data], old.[transfer_group], old.[created], old.[metadata]);
  INSERT INTO [charges_fts] (rowid, [id], [application], [application_fee], [balance_transaction], [customer], [invoice], [on_behalf_of], [order_id], [payment_intent], [review], [source_transfer], [transfer], [billing_details], [calculated_statement_descriptor], [currency], [description], [failure_code], [failure_message], [fraud_details], [outcome], [payment_method], [payment_method_details], [payment_method_details_type], [receipt_email], [receipt_number], [receipt_url], [refunds], [shipping], [statement_descriptor], [statement_descriptor_suffix], [status], [transfer_data], [transfer_group], [created], [metadata]) VALUES (new.rowid, new.[id], new.[application], new.[application_fee], new.[balance_transaction], new.[customer], new.[invoice], new.[on_behalf_of], new.[order_id], new.[payment_intent], new.[review], new.[source_transfer], new.[transfer], new.[billing_details], new.[calculated_statement_descriptor], new.[currency], new.[description], new.[failure_code], new.[failure_message], new.[fraud_details], new.[outcome], new.[payment_method], new.[payment_method_details], new.[payment_method_details_type], new.[receipt_email], new.[receipt_number], new.[receipt_url], new.[refunds], new.[shipping], new.[statement_descriptor], new.[statement_descriptor_suffix], new.[status], new.[transfer_data], new.[transfer_group], new.[created], new.[metadata]);
END;
CREATE TRIGGER [coupons_ai] AFTER INSERT ON [coupons] BEGIN
  INSERT INTO [coupons_fts] (rowid, [id], [name], [applies_to], [currency], [duration], [metadata]) VALUES (new.rowid, new.[id], new.[name], new.[applies_to], new.[currency], new.[duration], new.[metadata]);
END;
CREATE TRIGGER [coupons_ad] AFTER DELETE ON [coupons] BEGIN
  INSERT INTO [coupons_fts] ([coupons_fts], rowid, [id], [name], [applies_to], [currency], [duration], [metadata]) VALUES('delete', old.rowid, old.[id], old.[name], old.[applies_to], old.[currency], old.[duration], old.[metadata]);
END;
CREATE TRIGGER [coupons_au] AFTER UPDATE ON [coupons] BEGIN
  INSERT INTO [coupons_fts] ([coupons_fts], rowid, [id], [name], [applies_to], [currency], [duration], [metadata]) VALUES('delete', old.rowid, old.[id], old.[name], old.[applies_to], old.[currency], old.[duration], old.[metadata]);
  INSERT INTO [coupons_fts] (rowid, [id], [name], [applies_to], [currency], [duration], [metadata]) VALUES (new.rowid, new.[id], new.[name], new.[applies_to], new.[currency], new.[duration], new.[metadata]);
END;
CREATE TRIGGER [credit_notes_ai] AFTER INSERT ON [credit_notes] BEGIN
  INSERT INTO [credit_notes_fts] (rowid, [id], [type], [customer], [customer_balance_transaction], [invoice], [refund], [currency], [discount_amounts], [lines_first_x], [memo], [number], [pdf], [reason], [status], [tax_amounts], [voided_at], [created], [metadata]) VALUES (new.rowid, new.[id], new.[type], new.[customer], new.[customer_balance_transaction], new.[invoice], new.[refund], new.[currency], new.[discount_amounts], new.[lines_first_x], new.[memo], new.[number], new.[pdf], new.[reason], new.[status], new.[tax_amounts], new.[voided_at], new.[created], new.[metadata]);
END;
CREATE TRIGGER [credit_notes_ad] AFTER DELETE ON [credit_notes] BEGIN
  INSERT INTO [credit_notes_fts] ([credit_notes_fts], rowid, [id], [type], [customer], [customer_balance_transaction], [invoice], [refund], [currency], [discount_amounts], [lines_first_x], [memo], [number], [pdf], [reason], [status], [tax_amounts], [voided_at], [created], [metadata]) VALUES('delete', old.rowid, old.[id], old.[type], old.[customer], old.[customer_balance_transaction], old.[invoice], old.[refund], old.[currency], old.[discount_amounts], old.[lines_first_x], old.[memo], old.[number], old.[pdf], old.[reason], old.[status], old.[tax_amounts], old.[voided_at], old.[created], old.[metadata]);
END;
CREATE TRIGGER [credit_notes_au] AFTER UPDATE ON [credit_notes] BEGIN
  INSERT INTO [credit_notes_fts] ([credit_notes_fts], rowid, [id], [type], [customer], [customer_balance_transaction], [invoice], [refund], [currency], [discount_amounts], [lines_first_x], [memo], [number], [pdf], [reason], [status], [tax_amounts], [voided_at], [created], [metadata]) VALUES('delete', old.rowid, old.[id], old.[type], old.[customer], old.[customer_balance_transaction], old.[invoice], old.[refund], old.[currency], old.[discount_amounts], old.[lines_first_x], old.[memo], old.[number], old.[pdf], old.[reason], old.[status], old.[tax_amounts], old.[voided_at], old.[created], old.[metadata]);
  INSERT INTO [credit_notes_fts] (rowid, [id], [type], [customer], [customer_balance_transaction], [invoice], [refund], [currency], [discount_amounts], [lines_first_x], [memo], [number], [pdf], [reason], [status], [tax_amounts], [voided_at], [created], [metadata]) VALUES (new.rowid, new.[id], new.[type], new.[customer], new.[customer_balance_transaction], new.[invoice], new.[refund], new.[currency], new.[discount_amounts], new.[lines_first_x], new.[memo], new.[number], new.[pdf], new.[reason], new.[status], new.[tax_amounts], new.[voided_at], new.[created], new.[metadata]);
END;
CREATE TRIGGER [tax_rates_ai] AFTER INSERT ON [tax_rates] BEGIN
  INSERT INTO [tax_rates_fts] (rowid, [id], [description], [display_name], [jurisdiction], [created], [metadata]) VALUES (new.rowid, new.[id], new.[description], new.[display_name], new.[jurisdiction], new.[created], new.[metadata]);
END;
CREATE TRIGGER [tax_rates_ad] AFTER DELETE ON [tax_rates] BEGIN
  INSERT INTO [tax_rates_fts] ([tax_rates_fts], rowid, [id], [description], [display_name], [jurisdiction], [created], [metadata]) VALUES('delete', old.rowid, old.[id], old.[description], old.[display_name], old.[jurisdiction], old.[created], old.[metadata]);
END;
CREATE TRIGGER [tax_rates_au] AFTER UPDATE ON [tax_rates] BEGIN
  INSERT INTO [tax_rates_fts] ([tax_rates_fts], rowid, [id], [description], [display_name], [jurisdiction], [created], [metadata]) VALUES('delete', old.rowid, old.[id], old.[description], old.[display_name], old.[jurisdiction], old.[created], old.[metadata]);
  INSERT INTO [tax_rates_fts] (rowid, [id], [description], [display_name], [jurisdiction], [created], [metadata]) VALUES (new.rowid, new.[id], new.[description], new.[display_name], new.[jurisdiction], new.[created], new.[metadata]);
END;
CREATE TRIGGER [tax_ids_ai] AFTER INSERT ON [tax_ids] BEGIN
  INSERT INTO [tax_ids_fts] (rowid, [id], [type], [customer], [country], [value], [verification], [created]) VALUES (new.rowid, new.[id], new.[type], new.[customer], new.[country], new.[value], new.[verification], new.[created]);
END;
CREATE TRIGGER [tax_ids_ad] AFTER DELETE ON [tax_ids] BEGIN
  INSERT INTO [tax_ids_fts] ([tax_ids_fts], rowid, [id], [type], [customer], [country], [value], [verification], [created]) VALUES('delete', old.rowid, old.[id], old.[type], old.[customer], old.[country], old.[value], old.[verification], old.[created]);
END;
CREATE TRIGGER [tax_ids_au] AFTER UPDATE ON [tax_ids] BEGIN
  INSERT INTO [tax_ids_fts] ([tax_ids_fts], rowid, [id], [type], [customer], [country], [value], [verification], [created]) VALUES('delete', old.rowid, old.[id], old.[type], old.[customer], old.[country], old.[value], old.[verification], old.[created]);
  INSERT INTO [tax_ids_fts] (rowid, [id], [type], [customer], [country], [value], [verification], [created]) VALUES (new.rowid, new.[id], new.[type], new.[customer], new.[country], new.[value], new.[verification], new.[created]);
END;
CREATE TRIGGER [subscription_schedules_ai] AFTER INSERT ON [subscription_schedules] BEGIN
  INSERT INTO [subscription_schedules_fts] (rowid, [id], [customer], [subscription], [canceled_at], [completed_at], [current_phase], [default_settings], [end_behavior], [phases], [released_at], [released_subscription], [status], [created], [metadata]) VALUES (new.rowid, new.[id], new.[customer], new.[subscription], new.[canceled_at], new.[completed_at], new.[current_phase], new.[default_settings], new.[end_behavior], new.[phases], new.[released_at], new.[released_subscription], new.[status], new.[created], new.[metadata]);
END;
CREATE TRIGGER [subscription_schedules_ad] AFTER DELETE ON [subscription_schedules] BEGIN
  INSERT INTO [subscription_schedules_fts] ([subscription_schedules_fts], rowid, [id], [customer], [subscription], [canceled_at], [completed_at], [current_phase], [default_settings], [end_behavior], [phases], [released_at], [released_subscription], [status], [created], [metadata]) VALUES('delete', old.rowid, old.[id], old.[customer], old.[subscription], old.[canceled_at], old.[completed_at], old.[current_phase], old.[default_settings], old.[end_behavior], old.[phases], old.[released_at], old.[released_subscription], old.[status], old.[created], old.[metadata]);
END;
CREATE TRIGGER [subscription_schedules_au] AFTER UPDATE ON [subscription_schedules] BEGIN
  INSERT INTO [subscription_schedules_fts] ([subscription_schedules_fts], rowid, [id], [customer], [subscription], [canceled_at], [completed_at], [current_phase], [default_settings], [end_behavior], [phases], [released_at], [released_subscription], [status], [created], [metadata]) VALUES('delete', old.rowid, old.[id], old.[customer], old.[subscription], old.[canceled_at], old.[completed_at], old.[current_phase], old.[default_settings], old.[end_behavior], old.[phases], old.[released_at], old.[released_subscription], old.[status], old.[created], old.[metadata]);
  INSERT INTO [subscription_schedules_fts] (rowid, [id], [customer], [subscription], [canceled_at], [completed_at], [current_phase], [default_settings], [end_behavior], [phases], [released_at], [released_subscription], [status], [created], [metadata]) VALUES (new.rowid, new.[id], new.[customer], new.[subscription], new.[canceled_at], new.[completed_at], new.[current_phase], new.[default_settings], new.[end_behavior], new.[phases], new.[released_at], new.[released_subscription], new.[status], new.[created], new.[metadata]);
END;
CREATE TRIGGER [subscription_items_ai] AFTER INSERT ON [subscription_items] BEGIN
  INSERT INTO [subscription_items_fts] (rowid, [id], [subscription], [billing_thresholds], [price], [tax_rates], [created], [metadata]) VALUES (new.rowid, new.[id], new.[subscription], new.[billing_thresholds], new.[price], new.[tax_rates], new.[created], new.[metadata]);
END;
CREATE TRIGGER [subscription_items_ad] AFTER DELETE ON [subscription_items] BEGIN
  INSERT INTO [subscription_items_fts] ([subscription_items_fts], rowid, [id], [subscription], [billing_thresholds], [price], [tax_rates], [created], [metadata]) VALUES('delete', old.rowid, old.[id], old.[subscription], old.[billing_thresholds], old.[price], old.[tax_rates], old.[created], old.[metadata]);
END;
CREATE TRIGGER [subscription_items_au] AFTER UPDATE ON [subscription_items] BEGIN
  INSERT INTO [subscription_items_fts] ([subscription_items_fts], rowid, [id], [subscription], [billing_thresholds], [price], [tax_rates], [created], [metadata]) VALUES('delete', old.rowid, old.[id], old.[subscription], old.[billing_thresholds], old.[price], old.[tax_rates], old.[created], old.[metadata]);
  INSERT INTO [subscription_items_fts] (rowid, [id], [subscription], [billing_thresholds], [price], [tax_rates], [created], [metadata]) VALUES (new.rowid, new.[id], new.[subscription], new.[billing_thresholds], new.[price], new.[tax_rates], new.[created], new.[metadata]);
END;
CREATE TRIGGER [subscriptions_ai] AFTER INSERT ON [subscriptions] BEGIN
  INSERT INTO [subscriptions_fts] (rowid, [id], [customer], [default_payment_method], [default_source], [latest_invoice], [pending_setup_intent], [schedule], [billing_cycle_anchor], [billing_thresholds], [cancel_at], [canceled_at], [collection_method], [current_period_end], [current_period_start], [default_tax_rates], [discount], [ended_at], [items], [next_pending_invoice_item_invoice], [pause_collection], [pending_invoice_item_interval], [pending_update], [start_date], [status], [transfer_data], [trial_end], [trial_start], [created], [metadata]) VALUES (new.rowid, new.[id], new.[customer], new.[default_payment_method], new.[default_source], new.[latest_invoice], new.[pending_setup_intent], new.[schedule], new.[billing_cycle_anchor], new.[billing_thresholds], new.[cancel_at], new.[canceled_at], new.[collection_method], new.[current_period_end], new.[current_period_start], new.[default_tax_rates], new.[discount], new.[ended_at], new.[items], new.[next_pending_invoice_item_invoice], new.[pause_collection], new.[pending_invoice_item_interval], new.[pending_update], new.[start_date], new.[status], new.[transfer_data], new.[trial_end], new.[trial_start], new.[created], new.[metadata]);
END;
CREATE TRIGGER [subscriptions_ad] AFTER DELETE ON [subscriptions] BEGIN
  INSERT INTO [subscriptions_fts] ([subscriptions_fts], rowid, [id], [customer], [default_payment_method], [default_source], [latest_invoice], [pending_setup_intent], [schedule], [billing_cycle_anchor], [billing_thresholds], [cancel_at], [canceled_at], [collection_method], [current_period_end], [current_period_start], [default_tax_rates], [discount], [ended_at], [items], [next_pending_invoice_item_invoice], [pause_collection], [pending_invoice_item_interval], [pending_update], [start_date], [status], [transfer_data], [trial_end], [trial_start], [created], [metadata]) VALUES('delete', old.rowid, old.[id], old.[customer], old.[default_payment_method], old.[default_source], old.[latest_invoice], old.[pending_setup_intent], old.[schedule], old.[billing_cycle_anchor], old.[billing_thresholds], old.[cancel_at], old.[canceled_at], old.[collection_method], old.[current_period_end], old.[current_period_start], old.[default_tax_rates], old.[discount], old.[ended_at], old.[items], old.[next_pending_invoice_item_invoice], old.[pause_collection], old.[pending_invoice_item_interval], old.[pending_update], old.[start_date], old.[status], old.[transfer_data], old.[trial_end], old.[trial_start], old.[created], old.[metadata]);
END;
CREATE TRIGGER [subscriptions_au] AFTER UPDATE ON [subscriptions] BEGIN
  INSERT INTO [subscriptions_fts] ([subscriptions_fts], rowid, [id], [customer], [default_payment_method], [default_source], [latest_invoice], [pending_setup_intent], [schedule], [billing_cycle_anchor], [billing_thresholds], [cancel_at], [canceled_at], [collection_method], [current_period_end], [current_period_start], [default_tax_rates], [discount], [ended_at], [items], [next_pending_invoice_item_invoice], [pause_collection], [pending_invoice_item_interval], [pending_update], [start_date], [status], [transfer_data], [trial_end], [trial_start], [created], [metadata]) VALUES('delete', old.rowid, old.[id], old.[customer], old.[default_payment_method], old.[default_source], old.[latest_invoice], old.[pending_setup_intent], old.[schedule], old.[billing_cycle_anchor], old.[billing_thresholds], old.[cancel_at], old.[canceled_at], old.[collection_method], old.[current_period_end], old.[current_period_start], old.[default_tax_rates], old.[discount], old.[ended_at], old.[items], old.[next_pending_invoice_item_invoice], old.[pause_collection], old.[pending_invoice_item_interval], old.[pending_update], old.[start_date], old.[status], old.[transfer_data], old.[trial_end], old.[trial_start], old.[created], old.[metadata]);
  INSERT INTO [subscriptions_fts] (rowid, [id], [customer], [default_payment_method], [default_source], [latest_invoice], [pending_setup_intent], [schedule], [billing_cycle_anchor], [billing_thresholds], [cancel_at], [canceled_at], [collection_method], [current_period_end], [current_period_start], [default_tax_rates], [discount], [ended_at], [items], [next_pending_invoice_item_invoice], [pause_collection], [pending_invoice_item_interval], [pending_update], [start_date], [status], [transfer_data], [trial_end], [trial_start], [created], [metadata]) VALUES (new.rowid, new.[id], new.[customer], new.[default_payment_method], new.[default_source], new.[latest_invoice], new.[pending_setup_intent], new.[schedule], new.[billing_cycle_anchor], new.[billing_thresholds], new.[cancel_at], new.[canceled_at], new.[collection_method], new.[current_period_end], new.[current_period_start], new.[default_tax_rates], new.[discount], new.[ended_at], new.[items], new.[next_pending_invoice_item_invoice], new.[pause_collection], new.[pending_invoice_item_interval], new.[pending_update], new.[start_date], new.[status], new.[transfer_data], new.[trial_end], new.[trial_start], new.[created], new.[metadata]);
END;
CREATE TRIGGER [sources_ai] AFTER INSERT ON [sources] BEGIN
  INSERT INTO [sources_fts] (rowid, [id], [type], [customer], [ach_credit_transfer], [ach_debit], [alipay], [au_becs_debit], [bancontact], [card], [card_present], [client_secret], [code_verification], [currency], [eps], [flow], [giropay], [ideal], [klarna], [multibanco], [owner], [p24], [receiver], [redirect], [sepa_debit], [sofort], [source_order], [statement_descriptor], [status], [three_d_secure], [usage_x], [wechat], [created], [metadata]) VALUES (new.rowid, new.[id], new.[type], new.[customer], new.[ach_credit_transfer], new.[ach_debit], new.[alipay], new.[au_becs_debit], new.[bancontact], new.[card], new.[card_present], new.[client_secret], new.[code_verification], new.[currency], new.[eps], new.[flow], new.[giropay], new.[ideal], new.[klarna], new.[multibanco], new.[owner], new.[p24], new.[receiver], new.[redirect], new.[sepa_debit], new.[sofort], new.[source_order], new.[statement_descriptor], new.[status], new.[three_d_secure], new.[usage_x], new.[wechat], new.[created], new.[metadata]);
END;
CREATE TRIGGER [sources_ad] AFTER DELETE ON [sources] BEGIN
  INSERT INTO [sources_fts] ([sources_fts], rowid, [id], [type], [customer], [ach_credit_transfer], [ach_debit], [alipay], [au_becs_debit], [bancontact], [card], [card_present], [client_secret], [code_verification], [currency], [eps], [flow], [giropay], [ideal], [klarna], [multibanco], [owner], [p24], [receiver], [redirect], [sepa_debit], [sofort], [source_order], [statement_descriptor], [status], [three_d_secure], [usage_x], [wechat], [created], [metadata]) VALUES('delete', old.rowid, old.[id], old.[type], old.[customer], old.[ach_credit_transfer], old.[ach_debit], old.[alipay], old.[au_becs_debit], old.[bancontact], old.[card], old.[card_present], old.[client_secret], old.[code_verification], old.[currency], old.[eps], old.[flow], old.[giropay], old.[ideal], old.[klarna], old.[multibanco], old.[owner], old.[p24], old.[receiver], old.[redirect], old.[sepa_debit], old.[sofort], old.[source_order], old.[statement_descriptor], old.[status], old.[three_d_secure], old.[usage_x], old.[wechat], old.[created], old.[metadata]);
END;
CREATE TRIGGER [sources_au] AFTER UPDATE ON [sources] BEGIN
  INSERT INTO [sources_fts] ([sources_fts], rowid, [id], [type], [customer], [ach_credit_transfer], [ach_debit], [alipay], [au_becs_debit], [bancontact], [card], [card_present], [client_secret], [code_verification], [currency], [eps], [flow], [giropay], [ideal], [klarna], [multibanco], [owner], [p24], [receiver], [redirect], [sepa_debit], [sofort], [source_order], [statement_descriptor], [status], [three_d_secure], [usage_x], [wechat], [created], [metadata]) VALUES('delete', old.rowid, old.[id], old.[type], old.[customer], old.[ach_credit_transfer], old.[ach_debit], old.[alipay], old.[au_becs_debit], old.[bancontact], old.[card], old.[card_present], old.[client_secret], old.[code_verification], old.[currency], old.[eps], old.[flow], old.[giropay], old.[ideal], old.[klarna], old.[multibanco], old.[owner], old.[p24], old.[receiver], old.[redirect], old.[sepa_debit], old.[sofort], old.[source_order], old.[statement_descriptor], old.[status], old.[three_d_secure], old.[usage_x], old.[wechat], old.[created], old.[metadata]);
  INSERT INTO [sources_fts] (rowid, [id], [type], [customer], [ach_credit_transfer], [ach_debit], [alipay], [au_becs_debit], [bancontact], [card], [card_present], [client_secret], [code_verification], [currency], [eps], [flow], [giropay], [ideal], [klarna], [multibanco], [owner], [p24], [receiver], [redirect], [sepa_debit], [sofort], [source_order], [statement_descriptor], [status], [three_d_secure], [usage_x], [wechat], [created], [metadata]) VALUES (new.rowid, new.[id], new.[type], new.[customer], new.[ach_credit_transfer], new.[ach_debit], new.[alipay], new.[au_becs_debit], new.[bancontact], new.[card], new.[card_present], new.[client_secret], new.[code_verification], new.[currency], new.[eps], new.[flow], new.[giropay], new.[ideal], new.[klarna], new.[multibanco], new.[owner], new.[p24], new.[receiver], new.[redirect], new.[sepa_debit], new.[sofort], new.[source_order], new.[statement_descriptor], new.[status], new.[three_d_secure], new.[usage_x], new.[wechat], new.[created], new.[metadata]);
END;
CREATE TRIGGER [skus_ai] AFTER INSERT ON [skus] BEGIN
  INSERT INTO [skus_fts] (rowid, [id], [product], [attributes], [currency], [image], [inventory], [package_dimensions], [created], [updated], [metadata]) VALUES (new.rowid, new.[id], new.[product], new.[attributes], new.[currency], new.[image], new.[inventory], new.[package_dimensions], new.[created], new.[updated], new.[metadata]);
END;
CREATE TRIGGER [skus_ad] AFTER DELETE ON [skus] BEGIN
  INSERT INTO [skus_fts] ([skus_fts], rowid, [id], [product], [attributes], [currency], [image], [inventory], [package_dimensions], [created], [updated], [metadata]) VALUES('delete', old.rowid, old.[id], old.[product], old.[attributes], old.[currency], old.[image], old.[inventory], old.[package_dimensions], old.[created], old.[updated], old.[metadata]);
END;
CREATE TRIGGER [skus_au] AFTER UPDATE ON [skus] BEGIN
  INSERT INTO [skus_fts] ([skus_fts], rowid, [id], [product], [attributes], [currency], [image], [inventory], [package_dimensions], [created], [updated], [metadata]) VALUES('delete', old.rowid, old.[id], old.[product], old.[attributes], old.[currency], old.[image], old.[inventory], old.[package_dimensions], old.[created], old.[updated], old.[metadata]);
  INSERT INTO [skus_fts] (rowid, [id], [product], [attributes], [currency], [image], [inventory], [package_dimensions], [created], [updated], [metadata]) VALUES (new.rowid, new.[id], new.[product], new.[attributes], new.[currency], new.[image], new.[inventory], new.[package_dimensions], new.[created], new.[updated], new.[metadata]);
END;
CREATE TRIGGER [setup_intents_ai] AFTER INSERT ON [setup_intents] BEGIN
  INSERT INTO [setup_intents_fts] (rowid, [id], [application], [customer], [latest_attempt], [mandate], [on_behalf_of], [payment_method], [single_use_mandate], [cancellation_reason], [client_secret], [description], [last_setup_error], [next_action], [payment_method_options], [payment_method_types], [status], [usage_x], [created], [metadata]) VALUES (new.rowid, new.[id], new.[application], new.[customer], new.[latest_attempt], new.[mandate], new.[on_behalf_of], new.[payment_method], new.[single_use_mandate], new.[cancellation_reason], new.[client_secret], new.[description], new.[last_setup_error], new.[next_action], new.[payment_method_options], new.[payment_method_types], new.[status], new.[usage_x], new.[created], new.[metadata]);
END;
CREATE TRIGGER [setup_intents_ad] AFTER DELETE ON [setup_intents] BEGIN
  INSERT INTO [setup_intents_fts] ([setup_intents_fts], rowid, [id], [application], [customer], [latest_attempt], [mandate], [on_behalf_of], [payment_method], [single_use_mandate], [cancellation_reason], [client_secret], [description], [last_setup_error], [next_action], [payment_method_options], [payment_method_types], [status], [usage_x], [created], [metadata]) VALUES('delete', old.rowid, old.[id], old.[application], old.[customer], old.[latest_attempt], old.[mandate], old.[on_behalf_of], old.[payment_method], old.[single_use_mandate], old.[cancellation_reason], old.[client_secret], old.[description], old.[last_setup_error], old.[next_action], old.[payment_method_options], old.[payment_method_types], old.[status], old.[usage_x], old.[created], old.[metadata]);
END;
CREATE TRIGGER [setup_intents_au] AFTER UPDATE ON [setup_intents] BEGIN
  INSERT INTO [setup_intents_fts] ([setup_intents_fts], rowid, [id], [application], [customer], [latest_attempt], [mandate], [on_behalf_of], [payment_method], [single_use_mandate], [cancellation_reason], [client_secret], [description], [last_setup_error], [next_action], [payment_method_options], [payment_method_types], [status], [usage_x], [created], [metadata]) VALUES('delete', old.rowid, old.[id], old.[application], old.[customer], old.[latest_attempt], old.[mandate], old.[on_behalf_of], old.[payment_method], old.[single_use_mandate], old.[cancellation_reason], old.[client_secret], old.[description], old.[last_setup_error], old.[next_action], old.[payment_method_options], old.[payment_method_types], old.[status], old.[usage_x], old.[created], old.[metadata]);
  INSERT INTO [setup_intents_fts] (rowid, [id], [application], [customer], [latest_attempt], [mandate], [on_behalf_of], [payment_method], [single_use_mandate], [cancellation_reason], [client_secret], [description], [last_setup_error], [next_action], [payment_method_options], [payment_method_types], [status], [usage_x], [created], [metadata]) VALUES (new.rowid, new.[id], new.[application], new.[customer], new.[latest_attempt], new.[mandate], new.[on_behalf_of], new.[payment_method], new.[single_use_mandate], new.[cancellation_reason], new.[client_secret], new.[description], new.[last_setup_error], new.[next_action], new.[payment_method_options], new.[payment_method_types], new.[status], new.[usage_x], new.[created], new.[metadata]);
END;
CREATE TRIGGER [refunds_ai] AFTER INSERT ON [refunds] BEGIN
  INSERT INTO [refunds_fts] (rowid, [id], [balance_transaction], [charge], [failure_balance_transaction], [payment_intent], [source_transfer_reversal], [transfer_reversal], [currency], [description], [failure_reason], [reason], [receipt_number], [status], [created], [metadata]) VALUES (new.rowid, new.[id], new.[balance_transaction], new.[charge], new.[failure_balance_transaction], new.[payment_intent], new.[source_transfer_reversal], new.[transfer_reversal], new.[currency], new.[description], new.[failure_reason], new.[reason], new.[receipt_number], new.[status], new.[created], new.[metadata]);
END;
CREATE TRIGGER [refunds_ad] AFTER DELETE ON [refunds] BEGIN
  INSERT INTO [refunds_fts] ([refunds_fts], rowid, [id], [balance_transaction], [charge], [failure_balance_transaction], [payment_intent], [source_transfer_reversal], [transfer_reversal], [currency], [description], [failure_reason], [reason], [receipt_number], [status], [created], [metadata]) VALUES('delete', old.rowid, old.[id], old.[balance_transaction], old.[charge], old.[failure_balance_transaction], old.[payment_intent], old.[source_transfer_reversal], old.[transfer_reversal], old.[currency], old.[description], old.[failure_reason], old.[reason], old.[receipt_number], old.[status], old.[created], old.[metadata]);
END;
CREATE TRIGGER [refunds_au] AFTER UPDATE ON [refunds] BEGIN
  INSERT INTO [refunds_fts] ([refunds_fts], rowid, [id], [balance_transaction], [charge], [failure_balance_transaction], [payment_intent], [source_transfer_reversal], [transfer_reversal], [currency], [description], [failure_reason], [reason], [receipt_number], [status], [created], [metadata]) VALUES('delete', old.rowid, old.[id], old.[balance_transaction], old.[charge], old.[failure_balance_transaction], old.[payment_intent], old.[source_transfer_reversal], old.[transfer_reversal], old.[currency], old.[description], old.[failure_reason], old.[reason], old.[receipt_number], old.[status], old.[created], old.[metadata]);
  INSERT INTO [refunds_fts] (rowid, [id], [balance_transaction], [charge], [failure_balance_transaction], [payment_intent], [source_transfer_reversal], [transfer_reversal], [currency], [description], [failure_reason], [reason], [receipt_number], [status], [created], [metadata]) VALUES (new.rowid, new.[id], new.[balance_transaction], new.[charge], new.[failure_balance_transaction], new.[payment_intent], new.[source_transfer_reversal], new.[transfer_reversal], new.[currency], new.[description], new.[failure_reason], new.[reason], new.[receipt_number], new.[status], new.[created], new.[metadata]);
END;
CREATE TRIGGER [promotion_codes_ai] AFTER INSERT ON [promotion_codes] BEGIN
  INSERT INTO [promotion_codes_fts] (rowid, [id], [customer], [code], [coupon], [expires_at], [restrictions], [created], [metadata]) VALUES (new.rowid, new.[id], new.[customer], new.[code], new.[coupon], new.[expires_at], new.[restrictions], new.[created], new.[metadata]);
END;
CREATE TRIGGER [promotion_codes_ad] AFTER DELETE ON [promotion_codes] BEGIN
  INSERT INTO [promotion_codes_fts] ([promotion_codes_fts], rowid, [id], [customer], [code], [coupon], [expires_at], [restrictions], [created], [metadata]) VALUES('delete', old.rowid, old.[id], old.[customer], old.[code], old.[coupon], old.[expires_at], old.[restrictions], old.[created], old.[metadata]);
END;
CREATE TRIGGER [promotion_codes_au] AFTER UPDATE ON [promotion_codes] BEGIN
  INSERT INTO [promotion_codes_fts] ([promotion_codes_fts], rowid, [id], [customer], [code], [coupon], [expires_at], [restrictions], [created], [metadata]) VALUES('delete', old.rowid, old.[id], old.[customer], old.[code], old.[coupon], old.[expires_at], old.[restrictions], old.[created], old.[metadata]);
  INSERT INTO [promotion_codes_fts] (rowid, [id], [customer], [code], [coupon], [expires_at], [restrictions], [created], [metadata]) VALUES (new.rowid, new.[id], new.[customer], new.[code], new.[coupon], new.[expires_at], new.[restrictions], new.[created], new.[metadata]);
END;
CREATE TRIGGER [products_ai] AFTER INSERT ON [products] BEGIN
  INSERT INTO [products_fts] (rowid, [id], [type], [name], [attributes], [caption], [deactivate_on], [description], [images], [package_dimensions], [statement_descriptor], [unit_label], [url], [updated], [created], [metadata]) VALUES (new.rowid, new.[id], new.[type], new.[name], new.[attributes], new.[caption], new.[deactivate_on], new.[description], new.[images], new.[package_dimensions], new.[statement_descriptor], new.[unit_label], new.[url], new.[updated], new.[created], new.[metadata]);
END;
CREATE TRIGGER [products_ad] AFTER DELETE ON [products] BEGIN
  INSERT INTO [products_fts] ([products_fts], rowid, [id], [type], [name], [attributes], [caption], [deactivate_on], [description], [images], [package_dimensions], [statement_descriptor], [unit_label], [url], [updated], [created], [metadata]) VALUES('delete', old.rowid, old.[id], old.[type], old.[name], old.[attributes], old.[caption], old.[deactivate_on], old.[description], old.[images], old.[package_dimensions], old.[statement_descriptor], old.[unit_label], old.[url], old.[updated], old.[created], old.[metadata]);
END;
CREATE TRIGGER [products_au] AFTER UPDATE ON [products] BEGIN
  INSERT INTO [products_fts] ([products_fts], rowid, [id], [type], [name], [attributes], [caption], [deactivate_on], [description], [images], [package_dimensions], [statement_descriptor], [unit_label], [url], [updated], [created], [metadata]) VALUES('delete', old.rowid, old.[id], old.[type], old.[name], old.[attributes], old.[caption], old.[deactivate_on], old.[description], old.[images], old.[package_dimensions], old.[statement_descriptor], old.[unit_label], old.[url], old.[updated], old.[created], old.[metadata]);
  INSERT INTO [products_fts] (rowid, [id], [type], [name], [attributes], [caption], [deactivate_on], [description], [images], [package_dimensions], [statement_descriptor], [unit_label], [url], [updated], [created], [metadata]) VALUES (new.rowid, new.[id], new.[type], new.[name], new.[attributes], new.[caption], new.[deactivate_on], new.[description], new.[images], new.[package_dimensions], new.[statement_descriptor], new.[unit_label], new.[url], new.[updated], new.[created], new.[metadata]);
END;
CREATE TRIGGER [prices_ai] AFTER INSERT ON [prices] BEGIN
  INSERT INTO [prices_fts] (rowid, [id], [type], [product], [billing_scheme], [currency], [lookup_key], [nickname], [recurring], [tiers], [tiers_mode], [transform_quantity], [unit_amount_decimal], [created], [metadata]) VALUES (new.rowid, new.[id], new.[type], new.[product], new.[billing_scheme], new.[currency], new.[lookup_key], new.[nickname], new.[recurring], new.[tiers], new.[tiers_mode], new.[transform_quantity], new.[unit_amount_decimal], new.[created], new.[metadata]);
END;
CREATE TRIGGER [prices_ad] AFTER DELETE ON [prices] BEGIN
  INSERT INTO [prices_fts] ([prices_fts], rowid, [id], [type], [product], [billing_scheme], [currency], [lookup_key], [nickname], [recurring], [tiers], [tiers_mode], [transform_quantity], [unit_amount_decimal], [created], [metadata]) VALUES('delete', old.rowid, old.[id], old.[type], old.[product], old.[billing_scheme], old.[currency], old.[lookup_key], old.[nickname], old.[recurring], old.[tiers], old.[tiers_mode], old.[transform_quantity], old.[unit_amount_decimal], old.[created], old.[metadata]);
END;
CREATE TRIGGER [prices_au] AFTER UPDATE ON [prices] BEGIN
  INSERT INTO [prices_fts] ([prices_fts], rowid, [id], [type], [product], [billing_scheme], [currency], [lookup_key], [nickname], [recurring], [tiers], [tiers_mode], [transform_quantity], [unit_amount_decimal], [created], [metadata]) VALUES('delete', old.rowid, old.[id], old.[type], old.[product], old.[billing_scheme], old.[currency], old.[lookup_key], old.[nickname], old.[recurring], old.[tiers], old.[tiers_mode], old.[transform_quantity], old.[unit_amount_decimal], old.[created], old.[metadata]);
  INSERT INTO [prices_fts] (rowid, [id], [type], [product], [billing_scheme], [currency], [lookup_key], [nickname], [recurring], [tiers], [tiers_mode], [transform_quantity], [unit_amount_decimal], [created], [metadata]) VALUES (new.rowid, new.[id], new.[type], new.[product], new.[billing_scheme], new.[currency], new.[lookup_key], new.[nickname], new.[recurring], new.[tiers], new.[tiers_mode], new.[transform_quantity], new.[unit_amount_decimal], new.[created], new.[metadata]);
END;
CREATE TRIGGER [payment_intents_ai] AFTER INSERT ON [payment_intents] BEGIN
  INSERT INTO [payment_intents_fts] (rowid, [id], [application], [customer], [invoice], [on_behalf_of], [payment_method], [review], [canceled_at], [cancellation_reason], [capture_method], [client_secret], [confirmation_method], [currency], [description], [last_payment_error], [next_action], [payment_method_options], [payment_method_types], [receipt_email], [setup_future_usage], [shipping], [statement_descriptor], [statement_descriptor_suffix], [status], [transfer_data_destination], [transfer_group], [created], [metadata]) VALUES (new.rowid, new.[id], new.[application], new.[customer], new.[invoice], new.[on_behalf_of], new.[payment_method], new.[review], new.[canceled_at], new.[cancellation_reason], new.[capture_method], new.[client_secret], new.[confirmation_method], new.[currency], new.[description], new.[last_payment_error], new.[next_action], new.[payment_method_options], new.[payment_method_types], new.[receipt_email], new.[setup_future_usage], new.[shipping], new.[statement_descriptor], new.[statement_descriptor_suffix], new.[status], new.[transfer_data_destination], new.[transfer_group], new.[created], new.[metadata]);
END;
CREATE TRIGGER [payment_intents_ad] AFTER DELETE ON [payment_intents] BEGIN
  INSERT INTO [payment_intents_fts] ([payment_intents_fts], rowid, [id], [application], [customer], [invoice], [on_behalf_of], [payment_method], [review], [canceled_at], [cancellation_reason], [capture_method], [client_secret], [confirmation_method], [currency], [description], [last_payment_error], [next_action], [payment_method_options], [payment_method_types], [receipt_email], [setup_future_usage], [shipping], [statement_descriptor], [statement_descriptor_suffix], [status], [transfer_data_destination], [transfer_group], [created], [metadata]) VALUES('delete', old.rowid, old.[id], old.[application], old.[customer], old.[invoice], old.[on_behalf_of], old.[payment_method], old.[review], old.[canceled_at], old.[cancellation_reason], old.[capture_method], old.[client_secret], old.[confirmation_method], old.[currency], old.[description], old.[last_payment_error], old.[next_action], old.[payment_method_options], old.[payment_method_types], old.[receipt_email], old.[setup_future_usage], old.[shipping], old.[statement_descriptor], old.[statement_descriptor_suffix], old.[status], old.[transfer_data_destination], old.[transfer_group], old.[created], old.[metadata]);
END;
CREATE TRIGGER [payment_intents_au] AFTER UPDATE ON [payment_intents] BEGIN
  INSERT INTO [payment_intents_fts] ([payment_intents_fts], rowid, [id], [application], [customer], [invoice], [on_behalf_of], [payment_method], [review], [canceled_at], [cancellation_reason], [capture_method], [client_secret], [confirmation_method], [currency], [description], [last_payment_error], [next_action], [payment_method_options], [payment_method_types], [receipt_email], [setup_future_usage], [shipping], [statement_descriptor], [statement_descriptor_suffix], [status], [transfer_data_destination], [transfer_group], [created], [metadata]) VALUES('delete', old.rowid, old.[id], old.[application], old.[customer], old.[invoice], old.[on_behalf_of], old.[payment_method], old.[review], old.[canceled_at], old.[cancellation_reason], old.[capture_method], old.[client_secret], old.[confirmation_method], old.[currency], old.[description], old.[last_payment_error], old.[next_action], old.[payment_method_options], old.[payment_method_types], old.[receipt_email], old.[setup_future_usage], old.[shipping], old.[statement_descriptor], old.[statement_descriptor_suffix], old.[status], old.[transfer_data_destination], old.[transfer_group], old.[created], old.[metadata]);
  INSERT INTO [payment_intents_fts] (rowid, [id], [application], [customer], [invoice], [on_behalf_of], [payment_method], [review], [canceled_at], [cancellation_reason], [capture_method], [client_secret], [confirmation_method], [currency], [description], [last_payment_error], [next_action], [payment_method_options], [payment_method_types], [receipt_email], [setup_future_usage], [shipping], [statement_descriptor], [statement_descriptor_suffix], [status], [transfer_data_destination], [transfer_group], [created], [metadata]) VALUES (new.rowid, new.[id], new.[application], new.[customer], new.[invoice], new.[on_behalf_of], new.[payment_method], new.[review], new.[canceled_at], new.[cancellation_reason], new.[capture_method], new.[client_secret], new.[confirmation_method], new.[currency], new.[description], new.[last_payment_error], new.[next_action], new.[payment_method_options], new.[payment_method_types], new.[receipt_email], new.[setup_future_usage], new.[shipping], new.[statement_descriptor], new.[statement_descriptor_suffix], new.[status], new.[transfer_data_destination], new.[transfer_group], new.[created], new.[metadata]);
END;
CREATE TRIGGER [payment_methods_ai] AFTER INSERT ON [payment_methods] BEGIN
  INSERT INTO [payment_methods_fts] (rowid, [type], [id], [customer], [alipay], [au_becs_debit], [bacs_debit], [bancontact], [billing_details], [card], [card_present], [eps], [fpx], [giropay], [grabpay], [ideal], [interac_present], [oxxo], [p24], [sepa_debit], [sofort], [created], [metadata]) VALUES (new.rowid, new.[type], new.[id], new.[customer], new.[alipay], new.[au_becs_debit], new.[bacs_debit], new.[bancontact], new.[billing_details], new.[card], new.[card_present], new.[eps], new.[fpx], new.[giropay], new.[grabpay], new.[ideal], new.[interac_present], new.[oxxo], new.[p24], new.[sepa_debit], new.[sofort], new.[created], new.[metadata]);
END;
CREATE TRIGGER [payment_methods_ad] AFTER DELETE ON [payment_methods] BEGIN
  INSERT INTO [payment_methods_fts] ([payment_methods_fts], rowid, [type], [id], [customer], [alipay], [au_becs_debit], [bacs_debit], [bancontact], [billing_details], [card], [card_present], [eps], [fpx], [giropay], [grabpay], [ideal], [interac_present], [oxxo], [p24], [sepa_debit], [sofort], [created], [metadata]) VALUES('delete', old.rowid, old.[type], old.[id], old.[customer], old.[alipay], old.[au_becs_debit], old.[bacs_debit], old.[bancontact], old.[billing_details], old.[card], old.[card_present], old.[eps], old.[fpx], old.[giropay], old.[grabpay], old.[ideal], old.[interac_present], old.[oxxo], old.[p24], old.[sepa_debit], old.[sofort], old.[created], old.[metadata]);
END;
CREATE TRIGGER [payment_methods_au] AFTER UPDATE ON [payment_methods] BEGIN
  INSERT INTO [payment_methods_fts] ([payment_methods_fts], rowid, [type], [id], [customer], [alipay], [au_becs_debit], [bacs_debit], [bancontact], [billing_details], [card], [card_present], [eps], [fpx], [giropay], [grabpay], [ideal], [interac_present], [oxxo], [p24], [sepa_debit], [sofort], [created], [metadata]) VALUES('delete', old.rowid, old.[type], old.[id], old.[customer], old.[alipay], old.[au_becs_debit], old.[bacs_debit], old.[bancontact], old.[billing_details], old.[card], old.[card_present], old.[eps], old.[fpx], old.[giropay], old.[grabpay], old.[ideal], old.[interac_present], old.[oxxo], old.[p24], old.[sepa_debit], old.[sofort], old.[created], old.[metadata]);
  INSERT INTO [payment_methods_fts] (rowid, [type], [id], [customer], [alipay], [au_becs_debit], [bacs_debit], [bancontact], [billing_details], [card], [card_present], [eps], [fpx], [giropay], [grabpay], [ideal], [interac_present], [oxxo], [p24], [sepa_debit], [sofort], [created], [metadata]) VALUES (new.rowid, new.[type], new.[id], new.[customer], new.[alipay], new.[au_becs_debit], new.[bacs_debit], new.[bancontact], new.[billing_details], new.[card], new.[card_present], new.[eps], new.[fpx], new.[giropay], new.[grabpay], new.[ideal], new.[interac_present], new.[oxxo], new.[p24], new.[sepa_debit], new.[sofort], new.[created], new.[metadata]);
END;
CREATE TRIGGER [order_returns_ai] AFTER INSERT ON [order_returns] BEGIN
  INSERT INTO [order_returns_fts] (rowid, [id], [order_id], [refund], [currency], [items], [created]) VALUES (new.rowid, new.[id], new.[order_id], new.[refund], new.[currency], new.[items], new.[created]);
END;
CREATE TRIGGER [order_returns_ad] AFTER DELETE ON [order_returns] BEGIN
  INSERT INTO [order_returns_fts] ([order_returns_fts], rowid, [id], [order_id], [refund], [currency], [items], [created]) VALUES('delete', old.rowid, old.[id], old.[order_id], old.[refund], old.[currency], old.[items], old.[created]);
END;
CREATE TRIGGER [order_returns_au] AFTER UPDATE ON [order_returns] BEGIN
  INSERT INTO [order_returns_fts] ([order_returns_fts], rowid, [id], [order_id], [refund], [currency], [items], [created]) VALUES('delete', old.rowid, old.[id], old.[order_id], old.[refund], old.[currency], old.[items], old.[created]);
  INSERT INTO [order_returns_fts] (rowid, [id], [order_id], [refund], [currency], [items], [created]) VALUES (new.rowid, new.[id], new.[order_id], new.[refund], new.[currency], new.[items], new.[created]);
END;
CREATE TRIGGER [orders_ai] AFTER INSERT ON [orders] BEGIN
  INSERT INTO [orders_fts] (rowid, [id], [upstream_id], [charge], [customer], [application], [currency], [email], [external_coupon_code], [items], [returns], [selected_shipping_method], [shipping], [shipping_methods], [status], [status_transitions], [created], [updated], [metadata]) VALUES (new.rowid, new.[id], new.[upstream_id], new.[charge], new.[customer], new.[application], new.[currency], new.[email], new.[external_coupon_code], new.[items], new.[returns], new.[selected_shipping_method], new.[shipping], new.[shipping_methods], new.[status], new.[status_transitions], new.[created], new.[updated], new.[metadata]);
END;
CREATE TRIGGER [orders_ad] AFTER DELETE ON [orders] BEGIN
  INSERT INTO [orders_fts] ([orders_fts], rowid, [id], [upstream_id], [charge], [customer], [application], [currency], [email], [external_coupon_code], [items], [returns], [selected_shipping_method], [shipping], [shipping_methods], [status], [status_transitions], [created], [updated], [metadata]) VALUES('delete', old.rowid, old.[id], old.[upstream_id], old.[charge], old.[customer], old.[application], old.[currency], old.[email], old.[external_coupon_code], old.[items], old.[returns], old.[selected_shipping_method], old.[shipping], old.[shipping_methods], old.[status], old.[status_transitions], old.[created], old.[updated], old.[metadata]);
END;
CREATE TRIGGER [orders_au] AFTER UPDATE ON [orders] BEGIN
  INSERT INTO [orders_fts] ([orders_fts], rowid, [id], [upstream_id], [charge], [customer], [application], [currency], [email], [external_coupon_code], [items], [returns], [selected_shipping_method], [shipping], [shipping_methods], [status], [status_transitions], [created], [updated], [metadata]) VALUES('delete', old.rowid, old.[id], old.[upstream_id], old.[charge], old.[customer], old.[application], old.[currency], old.[email], old.[external_coupon_code], old.[items], old.[returns], old.[selected_shipping_method], old.[shipping], old.[shipping_methods], old.[status], old.[status_transitions], old.[created], old.[updated], old.[metadata]);
  INSERT INTO [orders_fts] (rowid, [id], [upstream_id], [charge], [customer], [application], [currency], [email], [external_coupon_code], [items], [returns], [selected_shipping_method], [shipping], [shipping_methods], [status], [status_transitions], [created], [updated], [metadata]) VALUES (new.rowid, new.[id], new.[upstream_id], new.[charge], new.[customer], new.[application], new.[currency], new.[email], new.[external_coupon_code], new.[items], new.[returns], new.[selected_shipping_method], new.[shipping], new.[shipping_methods], new.[status], new.[status_transitions], new.[created], new.[updated], new.[metadata]);
END;
CREATE TRIGGER [notification_events_ai] AFTER INSERT ON [notification_events] BEGIN
  INSERT INTO [notification_events_fts] (rowid, [id], [type], [resource], [action], [account], [api_version], [data_object_id], [data_object_object], [data_object], [data_previous_attributes], [request_id], [request_idempotency_key], [created]) VALUES (new.rowid, new.[id], new.[type], new.[resource], new.[action], new.[account], new.[api_version], new.[data_object_id], new.[data_object_object], new.[data_object], new.[data_previous_attributes], new.[request_id], new.[request_idempotency_key], new.[created]);
END;
CREATE TRIGGER [notification_events_ad] AFTER DELETE ON [notification_events] BEGIN
  INSERT INTO [notification_events_fts] ([notification_events_fts], rowid, [id], [type], [resource], [action], [account], [api_version], [data_object_id], [data_object_object], [data_object], [data_previous_attributes], [request_id], [request_idempotency_key], [created]) VALUES('delete', old.rowid, old.[id], old.[type], old.[resource], old.[action], old.[account], old.[api_version], old.[data_object_id], old.[data_object_object], old.[data_object], old.[data_previous_attributes], old.[request_id], old.[request_idempotency_key], old.[created]);
END;
CREATE TRIGGER [notification_events_au] AFTER UPDATE ON [notification_events] BEGIN
  INSERT INTO [notification_events_fts] ([notification_events_fts], rowid, [id], [type], [resource], [action], [account], [api_version], [data_object_id], [data_object_object], [data_object], [data_previous_attributes], [request_id], [request_idempotency_key], [created]) VALUES('delete', old.rowid, old.[id], old.[type], old.[resource], old.[action], old.[account], old.[api_version], old.[data_object_id], old.[data_object_object], old.[data_object], old.[data_previous_attributes], old.[request_id], old.[request_idempotency_key], old.[created]);
  INSERT INTO [notification_events_fts] (rowid, [id], [type], [resource], [action], [account], [api_version], [data_object_id], [data_object_object], [data_object], [data_previous_attributes], [request_id], [request_idempotency_key], [created]) VALUES (new.rowid, new.[id], new.[type], new.[resource], new.[action], new.[account], new.[api_version], new.[data_object_id], new.[data_object_object], new.[data_object], new.[data_previous_attributes], new.[request_id], new.[request_idempotency_key], new.[created]);
END;
CREATE TRIGGER [invoice_line_items_ai] AFTER INSERT ON [invoice_line_items] BEGIN
  INSERT INTO [invoice_line_items_fts] (rowid, [id], [type], [invoice], [invoice_item], [subscription], [subscription_item], [discounts], [currency], [description], [discount_amounts], [period_json], [price], [tax_amounts], [tax_rates], [metadata]) VALUES (new.rowid, new.[id], new.[type], new.[invoice], new.[invoice_item], new.[subscription], new.[subscription_item], new.[discounts], new.[currency], new.[description], new.[discount_amounts], new.[period_json], new.[price], new.[tax_amounts], new.[tax_rates], new.[metadata]);
END;
CREATE TRIGGER [invoice_line_items_ad] AFTER DELETE ON [invoice_line_items] BEGIN
  INSERT INTO [invoice_line_items_fts] ([invoice_line_items_fts], rowid, [id], [type], [invoice], [invoice_item], [subscription], [subscription_item], [discounts], [currency], [description], [discount_amounts], [period_json], [price], [tax_amounts], [tax_rates], [metadata]) VALUES('delete', old.rowid, old.[id], old.[type], old.[invoice], old.[invoice_item], old.[subscription], old.[subscription_item], old.[discounts], old.[currency], old.[description], old.[discount_amounts], old.[period_json], old.[price], old.[tax_amounts], old.[tax_rates], old.[metadata]);
END;
CREATE TRIGGER [invoice_line_items_au] AFTER UPDATE ON [invoice_line_items] BEGIN
  INSERT INTO [invoice_line_items_fts] ([invoice_line_items_fts], rowid, [id], [type], [invoice], [invoice_item], [subscription], [subscription_item], [discounts], [currency], [description], [discount_amounts], [period_json], [price], [tax_amounts], [tax_rates], [metadata]) VALUES('delete', old.rowid, old.[id], old.[type], old.[invoice], old.[invoice_item], old.[subscription], old.[subscription_item], old.[discounts], old.[currency], old.[description], old.[discount_amounts], old.[period_json], old.[price], old.[tax_amounts], old.[tax_rates], old.[metadata]);
  INSERT INTO [invoice_line_items_fts] (rowid, [id], [type], [invoice], [invoice_item], [subscription], [subscription_item], [discounts], [currency], [description], [discount_amounts], [period_json], [price], [tax_amounts], [tax_rates], [metadata]) VALUES (new.rowid, new.[id], new.[type], new.[invoice], new.[invoice_item], new.[subscription], new.[subscription_item], new.[discounts], new.[currency], new.[description], new.[discount_amounts], new.[period_json], new.[price], new.[tax_amounts], new.[tax_rates], new.[metadata]);
END;
CREATE TRIGGER [invoiceitems_ai] AFTER INSERT ON [invoiceitems] BEGIN
  INSERT INTO [invoiceitems_fts] (rowid, [id], [customer], [invoice], [subscription], [subscription_item], [discounts], [currency], [date_ts], [description], [period_json], [price], [tax_rates], [unit_amount_decimal], [metadata]) VALUES (new.rowid, new.[id], new.[customer], new.[invoice], new.[subscription], new.[subscription_item], new.[discounts], new.[currency], new.[date_ts], new.[description], new.[period_json], new.[price], new.[tax_rates], new.[unit_amount_decimal], new.[metadata]);
END;
CREATE TRIGGER [invoiceitems_ad] AFTER DELETE ON [invoiceitems] BEGIN
  INSERT INTO [invoiceitems_fts] ([invoiceitems_fts], rowid, [id], [customer], [invoice], [subscription], [subscription_item], [discounts], [currency], [date_ts], [description], [period_json], [price], [tax_rates], [unit_amount_decimal], [metadata]) VALUES('delete', old.rowid, old.[id], old.[customer], old.[invoice], old.[subscription], old.[subscription_item], old.[discounts], old.[currency], old.[date_ts], old.[description], old.[period_json], old.[price], old.[tax_rates], old.[unit_amount_decimal], old.[metadata]);
END;
CREATE TRIGGER [invoiceitems_au] AFTER UPDATE ON [invoiceitems] BEGIN
  INSERT INTO [invoiceitems_fts] ([invoiceitems_fts], rowid, [id], [customer], [invoice], [subscription], [subscription_item], [discounts], [currency], [date_ts], [description], [period_json], [price], [tax_rates], [unit_amount_decimal], [metadata]) VALUES('delete', old.rowid, old.[id], old.[customer], old.[invoice], old.[subscription], old.[subscription_item], old.[discounts], old.[currency], old.[date_ts], old.[description], old.[period_json], old.[price], old.[tax_rates], old.[unit_amount_decimal], old.[metadata]);
  INSERT INTO [invoiceitems_fts] (rowid, [id], [customer], [invoice], [subscription], [subscription_item], [discounts], [currency], [date_ts], [description], [period_json], [price], [tax_rates], [unit_amount_decimal], [metadata]) VALUES (new.rowid, new.[id], new.[customer], new.[invoice], new.[subscription], new.[subscription_item], new.[discounts], new.[currency], new.[date_ts], new.[description], new.[period_json], new.[price], new.[tax_rates], new.[unit_amount_decimal], new.[metadata]);
END;
CREATE TRIGGER [invoices_ai] AFTER INSERT ON [invoices] BEGIN
  INSERT INTO [invoices_fts] (rowid, [id], [charge], [customer], [default_payment_method], [default_source], [discounts], [payment_intent], [subscription], [account_country], [account_name], [billing_reason], [collection_method], [currency], [custom_fields], [customer_address], [customer_email], [customer_name], [customer_phone], [customer_shipping], [customer_tax_exempt], [customer_tax_ids], [default_tax_rates], [description], [due_date], [footer], [hosted_invoice_url], [invoice_pdf], [last_finalization_error], [lines_newest_10], [next_payment_attempt], [number], [period_end], [period_start], [receipt_number], [statement_descriptor], [status], [status_transitions], [threshold_reason], [total_discount_amounts], [total_tax_amounts], [transfer_data], [webhooks_delivered_at], [created], [metadata]) VALUES (new.rowid, new.[id], new.[charge], new.[customer], new.[default_payment_method], new.[default_source], new.[discounts], new.[payment_intent], new.[subscription], new.[account_country], new.[account_name], new.[billing_reason], new.[collection_method], new.[currency], new.[custom_fields], new.[customer_address], new.[customer_email], new.[customer_name], new.[customer_phone], new.[customer_shipping], new.[customer_tax_exempt], new.[customer_tax_ids], new.[default_tax_rates], new.[description], new.[due_date], new.[footer], new.[hosted_invoice_url], new.[invoice_pdf], new.[last_finalization_error], new.[lines_newest_10], new.[next_payment_attempt], new.[number], new.[period_end], new.[period_start], new.[receipt_number], new.[statement_descriptor], new.[status], new.[status_transitions], new.[threshold_reason], new.[total_discount_amounts], new.[total_tax_amounts], new.[transfer_data], new.[webhooks_delivered_at], new.[created], new.[metadata]);
END;
CREATE TRIGGER [invoices_ad] AFTER DELETE ON [invoices] BEGIN
  INSERT INTO [invoices_fts] ([invoices_fts], rowid, [id], [charge], [customer], [default_payment_method], [default_source], [discounts], [payment_intent], [subscription], [account_country], [account_name], [billing_reason], [collection_method], [currency], [custom_fields], [customer_address], [customer_email], [customer_name], [customer_phone], [customer_shipping], [customer_tax_exempt], [customer_tax_ids], [default_tax_rates], [description], [due_date], [footer], [hosted_invoice_url], [invoice_pdf], [last_finalization_error], [lines_newest_10], [next_payment_attempt], [number], [period_end], [period_start], [receipt_number], [statement_descriptor], [status], [status_transitions], [threshold_reason], [total_discount_amounts], [total_tax_amounts], [transfer_data], [webhooks_delivered_at], [created], [metadata]) VALUES('delete', old.rowid, old.[id], old.[charge], old.[customer], old.[default_payment_method], old.[default_source], old.[discounts], old.[payment_intent], old.[subscription], old.[account_country], old.[account_name], old.[billing_reason], old.[collection_method], old.[currency], old.[custom_fields], old.[customer_address], old.[customer_email], old.[customer_name], old.[customer_phone], old.[customer_shipping], old.[customer_tax_exempt], old.[customer_tax_ids], old.[default_tax_rates], old.[description], old.[due_date], old.[footer], old.[hosted_invoice_url], old.[invoice_pdf], old.[last_finalization_error], old.[lines_newest_10], old.[next_payment_attempt], old.[number], old.[period_end], old.[period_start], old.[receipt_number], old.[statement_descriptor], old.[status], old.[status_transitions], old.[threshold_reason], old.[total_discount_amounts], old.[total_tax_amounts], old.[transfer_data], old.[webhooks_delivered_at], old.[created], old.[metadata]);
END;
CREATE TRIGGER [invoices_au] AFTER UPDATE ON [invoices] BEGIN
  INSERT INTO [invoices_fts] ([invoices_fts], rowid, [id], [charge], [customer], [default_payment_method], [default_source], [discounts], [payment_intent], [subscription], [account_country], [account_name], [billing_reason], [collection_method], [currency], [custom_fields], [customer_address], [customer_email], [customer_name], [customer_phone], [customer_shipping], [customer_tax_exempt], [customer_tax_ids], [default_tax_rates], [description], [due_date], [footer], [hosted_invoice_url], [invoice_pdf], [last_finalization_error], [lines_newest_10], [next_payment_attempt], [number], [period_end], [period_start], [receipt_number], [statement_descriptor], [status], [status_transitions], [threshold_reason], [total_discount_amounts], [total_tax_amounts], [transfer_data], [webhooks_delivered_at], [created], [metadata]) VALUES('delete', old.rowid, old.[id], old.[charge], old.[customer], old.[default_payment_method], old.[default_source], old.[discounts], old.[payment_intent], old.[subscription], old.[account_country], old.[account_name], old.[billing_reason], old.[collection_method], old.[currency], old.[custom_fields], old.[customer_address], old.[customer_email], old.[customer_name], old.[customer_phone], old.[customer_shipping], old.[customer_tax_exempt], old.[customer_tax_ids], old.[default_tax_rates], old.[description], old.[due_date], old.[footer], old.[hosted_invoice_url], old.[invoice_pdf], old.[last_finalization_error], old.[lines_newest_10], old.[next_payment_attempt], old.[number], old.[period_end], old.[period_start], old.[receipt_number], old.[statement_descriptor], old.[status], old.[status_transitions], old.[threshold_reason], old.[total_discount_amounts], old.[total_tax_amounts], old.[transfer_data], old.[webhooks_delivered_at], old.[created], old.[metadata]);
  INSERT INTO [invoices_fts] (rowid, [id], [charge], [customer], [default_payment_method], [default_source], [discounts], [payment_intent], [subscription], [account_country], [account_name], [billing_reason], [collection_method], [currency], [custom_fields], [customer_address], [customer_email], [customer_name], [customer_phone], [customer_shipping], [customer_tax_exempt], [customer_tax_ids], [default_tax_rates], [description], [due_date], [footer], [hosted_invoice_url], [invoice_pdf], [last_finalization_error], [lines_newest_10], [next_payment_attempt], [number], [period_end], [period_start], [receipt_number], [statement_descriptor], [status], [status_transitions], [threshold_reason], [total_discount_amounts], [total_tax_amounts], [transfer_data], [webhooks_delivered_at], [created], [metadata]) VALUES (new.rowid, new.[id], new.[charge], new.[customer], new.[default_payment_method], new.[default_source], new.[discounts], new.[payment_intent], new.[subscription], new.[account_country], new.[account_name], new.[billing_reason], new.[collection_method], new.[currency], new.[custom_fields], new.[customer_address], new.[customer_email], new.[customer_name], new.[customer_phone], new.[customer_shipping], new.[customer_tax_exempt], new.[customer_tax_ids], new.[default_tax_rates], new.[description], new.[due_date], new.[footer], new.[hosted_invoice_url], new.[invoice_pdf], new.[last_finalization_error], new.[lines_newest_10], new.[next_payment_attempt], new.[number], new.[period_end], new.[period_start], new.[receipt_number], new.[statement_descriptor], new.[status], new.[status_transitions], new.[threshold_reason], new.[total_discount_amounts], new.[total_tax_amounts], new.[transfer_data], new.[webhooks_delivered_at], new.[created], new.[metadata]);
END;
CREATE TRIGGER [disputes_ai] AFTER INSERT ON [disputes] BEGIN
  INSERT INTO [disputes_fts] (rowid, [id], [charge], [payment_intent], [balance_transactions], [currency], [evidence], [evidence_details], [reason], [status], [created], [metadata]) VALUES (new.rowid, new.[id], new.[charge], new.[payment_intent], new.[balance_transactions], new.[currency], new.[evidence], new.[evidence_details], new.[reason], new.[status], new.[created], new.[metadata]);
END;
CREATE TRIGGER [disputes_ad] AFTER DELETE ON [disputes] BEGIN
  INSERT INTO [disputes_fts] ([disputes_fts], rowid, [id], [charge], [payment_intent], [balance_transactions], [currency], [evidence], [evidence_details], [reason], [status], [created], [metadata]) VALUES('delete', old.rowid, old.[id], old.[charge], old.[payment_intent], old.[balance_transactions], old.[currency], old.[evidence], old.[evidence_details], old.[reason], old.[status], old.[created], old.[metadata]);
END;
CREATE TRIGGER [disputes_au] AFTER UPDATE ON [disputes] BEGIN
  INSERT INTO [disputes_fts] ([disputes_fts], rowid, [id], [charge], [payment_intent], [balance_transactions], [currency], [evidence], [evidence_details], [reason], [status], [created], [metadata]) VALUES('delete', old.rowid, old.[id], old.[charge], old.[payment_intent], old.[balance_transactions], old.[currency], old.[evidence], old.[evidence_details], old.[reason], old.[status], old.[created], old.[metadata]);
  INSERT INTO [disputes_fts] (rowid, [id], [charge], [payment_intent], [balance_transactions], [currency], [evidence], [evidence_details], [reason], [status], [created], [metadata]) VALUES (new.rowid, new.[id], new.[charge], new.[payment_intent], new.[balance_transactions], new.[currency], new.[evidence], new.[evidence_details], new.[reason], new.[status], new.[created], new.[metadata]);
END;
CREATE TRIGGER [discounts_ai] AFTER INSERT ON [discounts] BEGIN
  INSERT INTO [discounts_fts] (rowid, [id], [coupon], [customer], [subscription], [invoice], [invoice_item], [promotion_code], [checkout_session], [start], [end_ts]) VALUES (new.rowid, new.[id], new.[coupon], new.[customer], new.[subscription], new.[invoice], new.[invoice_item], new.[promotion_code], new.[checkout_session], new.[start], new.[end_ts]);
END;
CREATE TRIGGER [discounts_ad] AFTER DELETE ON [discounts] BEGIN
  INSERT INTO [discounts_fts] ([discounts_fts], rowid, [id], [coupon], [customer], [subscription], [invoice], [invoice_item], [promotion_code], [checkout_session], [start], [end_ts]) VALUES('delete', old.rowid, old.[id], old.[coupon], old.[customer], old.[subscription], old.[invoice], old.[invoice_item], old.[promotion_code], old.[checkout_session], old.[start], old.[end_ts]);
END;
CREATE TRIGGER [discounts_au] AFTER UPDATE ON [discounts] BEGIN
  INSERT INTO [discounts_fts] ([discounts_fts], rowid, [id], [coupon], [customer], [subscription], [invoice], [invoice_item], [promotion_code], [checkout_session], [start], [end_ts]) VALUES('delete', old.rowid, old.[id], old.[coupon], old.[customer], old.[subscription], old.[invoice], old.[invoice_item], old.[promotion_code], old.[checkout_session], old.[start], old.[end_ts]);
  INSERT INTO [discounts_fts] (rowid, [id], [coupon], [customer], [subscription], [invoice], [invoice_item], [promotion_code], [checkout_session], [start], [end_ts]) VALUES (new.rowid, new.[id], new.[coupon], new.[customer], new.[subscription], new.[invoice], new.[invoice_item], new.[promotion_code], new.[checkout_session], new.[start], new.[end_ts]);
END;
CREATE TRIGGER [customers_ai] AFTER INSERT ON [customers] BEGIN
  INSERT INTO [customers_fts] (rowid, [id], [name], [email], [default_source], [address], [shipping], [currency], [description], [discount], [invoice_prefix], [invoice_settings], [phone], [preferred_locales], [tax_exempt], [created], [metadata]) VALUES (new.rowid, new.[id], new.[name], new.[email], new.[default_source], new.[address], new.[shipping], new.[currency], new.[description], new.[discount], new.[invoice_prefix], new.[invoice_settings], new.[phone], new.[preferred_locales], new.[tax_exempt], new.[created], new.[metadata]);
END;
CREATE TRIGGER [customers_ad] AFTER DELETE ON [customers] BEGIN
  INSERT INTO [customers_fts] ([customers_fts], rowid, [id], [name], [email], [default_source], [address], [shipping], [currency], [description], [discount], [invoice_prefix], [invoice_settings], [phone], [preferred_locales], [tax_exempt], [created], [metadata]) VALUES('delete', old.rowid, old.[id], old.[name], old.[email], old.[default_source], old.[address], old.[shipping], old.[currency], old.[description], old.[discount], old.[invoice_prefix], old.[invoice_settings], old.[phone], old.[preferred_locales], old.[tax_exempt], old.[created], old.[metadata]);
END;
CREATE TRIGGER [customers_au] AFTER UPDATE ON [customers] BEGIN
  INSERT INTO [customers_fts] ([customers_fts], rowid, [id], [name], [email], [default_source], [address], [shipping], [currency], [description], [discount], [invoice_prefix], [invoice_settings], [phone], [preferred_locales], [tax_exempt], [created], [metadata]) VALUES('delete', old.rowid, old.[id], old.[name], old.[email], old.[default_source], old.[address], old.[shipping], old.[currency], old.[description], old.[discount], old.[invoice_prefix], old.[invoice_settings], old.[phone], old.[preferred_locales], old.[tax_exempt], old.[created], old.[metadata]);
  INSERT INTO [customers_fts] (rowid, [id], [name], [email], [default_source], [address], [shipping], [currency], [description], [discount], [invoice_prefix], [invoice_settings], [phone], [preferred_locales], [tax_exempt], [created], [metadata]) VALUES (new.rowid, new.[id], new.[name], new.[email], new.[default_source], new.[address], new.[shipping], new.[currency], new.[description], new.[discount], new.[invoice_prefix], new.[invoice_settings], new.[phone], new.[preferred_locales], new.[tax_exempt], new.[created], new.[metadata]);
END;
CREATE TRIGGER [credit_note_line_items_ai] AFTER INSERT ON [credit_note_line_items] BEGIN
  INSERT INTO [credit_note_line_items_fts] (rowid, [id], [type], [credit_note_id], [description], [discount_amounts], [invoice_line_item], [tax_amounts], [tax_rates], [unit_amount_decimal]) VALUES (new.rowid, new.[id], new.[type], new.[credit_note_id], new.[description], new.[discount_amounts], new.[invoice_line_item], new.[tax_amounts], new.[tax_rates], new.[unit_amount_decimal]);
END;
CREATE TRIGGER [credit_note_line_items_ad] AFTER DELETE ON [credit_note_line_items] BEGIN
  INSERT INTO [credit_note_line_items_fts] ([credit_note_line_items_fts], rowid, [id], [type], [credit_note_id], [description], [discount_amounts], [invoice_line_item], [tax_amounts], [tax_rates], [unit_amount_decimal]) VALUES('delete', old.rowid, old.[id], old.[type], old.[credit_note_id], old.[description], old.[discount_amounts], old.[invoice_line_item], old.[tax_amounts], old.[tax_rates], old.[unit_amount_decimal]);
END;
CREATE TRIGGER [credit_note_line_items_au] AFTER UPDATE ON [credit_note_line_items] BEGIN
  INSERT INTO [credit_note_line_items_fts] ([credit_note_line_items_fts], rowid, [id], [type], [credit_note_id], [description], [discount_amounts], [invoice_line_item], [tax_amounts], [tax_rates], [unit_amount_decimal]) VALUES('delete', old.rowid, old.[id], old.[type], old.[credit_note_id], old.[description], old.[discount_amounts], old.[invoice_line_item], old.[tax_amounts], old.[tax_rates], old.[unit_amount_decimal]);
  INSERT INTO [credit_note_line_items_fts] (rowid, [id], [type], [credit_note_id], [description], [discount_amounts], [invoice_line_item], [tax_amounts], [tax_rates], [unit_amount_decimal]) VALUES (new.rowid, new.[id], new.[type], new.[credit_note_id], new.[description], new.[discount_amounts], new.[invoice_line_item], new.[tax_amounts], new.[tax_rates], new.[unit_amount_decimal]);
END;


END;