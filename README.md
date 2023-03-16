# Database migration strategy sample with using Atlas

This is a sample project for database migration strategy with using Atlas.

Please refer to the [atlas documentation](https://atlasgo.io/getting-started) for atlas usage itself.
This branch is aimed to describe the workflow of database migration with using atlas & github actions on postgres.

## Branches

Currently, main branch will represent the result of the migration strategy.
If I need to make a change to the migration strategy, I'll create a new branch, and make a new pull request to that branch to describe the sequence of the migration.

## Goals

- [ ] Establish declarative schema from existing database using atlas
- [ ] Establish integration test for constructing database from the scratch using declarative schema
- [ ] Establish integration test for declarative schema which will be triggered when changes on schema are made
- [ ] Make pull request to main branch for the changes on schema
  - [ ] Modification on declarative schema
  - [ ] Modification using manual migration script
    - [ ] Materialized view
    - [ ] Inserting initial data
- [ ] Establish continous deployment for the database (mocking managed database service)

## How about handling the features which are not supported by atlas?

Check manual migration doc: https://atlasgo.io/versioned/new  

- Inserting initial data is not a part of declarative schema, so we need to create manual migration for that.
- Capturing `view` or `trigger` is not supported by declarative schema of atlas, so we need to create manual migration for that.

### Possible solution

- Make manual migration script for the insertion, and view/trigger creation
  - We cannot use declarative schema directly for the SSOT
  - Already inserted data will be safely altered, changed by migration script
  - We need to run all the migration script from the scratch, when we need to create the initial database (e.g. integration test)
  - Only advantage is that we can generate migration script automatically from the declarative schema for the modification of the schema (not for the insertion of initial data or materialized view creation)

- Give up declarative schema, and use manual migration script for the whole database
  - We need to create manual migration script rather than auto creation of migration script from `atlas migration diff`
  - Migration script will be SSOT for the database

## Sequence

### Create database using initial sql script

This repository assumes that the database is already created, and migration strategy is about to be applied to the existing database.

The SQL script contains,

- Create database
- Create user
- Grant privileges to the user
- Create schema for created user
- Create tables
- Insert initial data
- Make views for materialized views


#### NOTE

Currently, atlas declarative migration does not support materialized views, so we need to create manual migration for materialized views.
Inserting initial data is also cannot be done with declarative migration, so we need to create manual migration for that.



## References

- [Picking a database migration tool for Go projects in 2023](https://atlasgo.io/blog/2022/12/01/picking-database-migration-tool)
- [golang-migrate tutorial for postgres](https://github.com/golang-migrate/migrate/blob/master/database/postgres/TUTORIAL.md)
