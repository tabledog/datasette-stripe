# Get a bash prompt into the last run container.
docker exec -it $(docker ps | grep 'datasette-stripe' | awk '{ print $1 }') bash;