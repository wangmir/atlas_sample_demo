#!/bin/bash

# This script is for establishing the database from the scratch using atlas schema.

# Establish migration test container on docker to 5832
docker run --rm --name migrationTest -p 5832:5432 -e POSTGRES_PASSWORD=test1234 -d postgres

# wait for docker stabilization
sleep 5

# Initialize database, this part still should be done by SQL because it's not related to schema but to database setup.
PGPASSWORD=test1234 psql -h localhost -p 5832 -U postgres -f initdb.sql

# Get current status (empty) of postgressql
atlas migrate status --env local

# Apply schema
atlas migrate apply --env local
