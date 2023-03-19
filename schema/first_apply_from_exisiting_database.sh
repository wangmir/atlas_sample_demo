#!/bin/bash

# This script is to update from already established database to atlas schema at first time.
# Atlas stores the migration information in the table, so we need to explicitly set the baseline at first migration of atlas.
# When trying to test this script, you need to run initial_database/establish.sh first.
atlas migrate apply \
  --url "postgres://testuser:test1234@localhost:5832/test?sslmode=disable" \
  --dir "file://migrations" \
  --baseline "20230319165852" \
  --dry-run

atlas migrate apply \
  --url "postgres://testuser:test1234@localhost:5832/test?sslmode=disable" \
  --dir "file://migrations" \
  --baseline "20230319165852"