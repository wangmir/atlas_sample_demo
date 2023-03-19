#!/bin/bash

# This script is to generate migration script from the atlas schema & existing migration script for former database.

atlas migrate diff \
  --dir "file://migrations" \
  --to "file://test_ddl.hcl" \
  --dev-url "docker://postgres/15"