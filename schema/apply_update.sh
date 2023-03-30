#!/bin/bash

# Check first with dry run
atlas migrate apply \
  --env local \
  --dry-run

# This script is to update existing database for new change.
atlas migrate apply --env local