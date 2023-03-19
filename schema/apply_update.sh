#!/bin/bash

# Check first with dry run
atlas migrate apply \
  --url "postgres://testuser:test1234@localhost:5832/test?sslmode=disable" \
  --dir "file://migrations" \
  --dry-run

# This script is to update existing database for new change.
atlas migrate apply \
  --url "postgres://testuser:test1234@localhost:5832/test?sslmode=disable" \
  --dir "file://migrations"