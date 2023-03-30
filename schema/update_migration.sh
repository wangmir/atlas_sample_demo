#!/bin/bash

# This script is to generate migration script from the atlas schema & existing migration script for former database.

atlas migrate diff --env local