#!/bin/bash

# Establish migration test container on docker to 5832
docker run --rm --name migrationTest -p 5832:5432 -e POSTGRES_PASSWORD=test1234 -d postgres

# wait for docker stabilization
sleep 5

# Initialize
PGPASSWORD=test1234 psql -h localhost -p 5832 -U postgres -f initdb.sql

# Init tables
PGPASSWORD=test1234 psql -h localhost -p 5832 -U testuser -d test -f inittables.sql

# Insert initial data
PGPASSWORD=test1234 psql -h localhost -p 5832 -U testuser -d test -f insertdata.sql

# Create index with name
PGPASSWORD=test1234 psql -h localhost -p 5832 -U testuser -d test -f createindex.sql

# Create materialized view
PGPASSWORD=test1234 psql -h localhost -p 5832 -U testuser -d test -f createview.sql