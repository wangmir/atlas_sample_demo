# Initial schema setup

## Get the baseline migration script from the existing database

```bash

atlas migrate diff my_baseline --dev-url "docker://postgres/15" --to "postgres://testuser:test1234@localhost:5832/test?sslmode=disable"
```


## Create ddl file from the existing database

```bash
atlas schema inspect -u "postgres://testuser:test1234@localhost:5832/test?sslmode=disable" > test_ddl.hcl
```

## Create manual migration script for unsupported features by atlas

### Materialized view

1. Create manual migration script with `atlas migrate new`

```bash
atlas migrate new add_materialized_view
```

2. Add manual script into the file: Check `migrations/20230319162418_add_materialized_view.sql`

```sql
CREATE MATERIALIZED VIEW testschema.test_materialized_view AS
SELECT
    CONCAT(t.id, t.name, t.description) AS t_data,
    NOW() AS t_time
FROM
    testschema.testtable AS t;
```

3. Refresh hash with `atlas migrate hash`


### Inserting initial data

1. Create manual migration script with `atlas migrate new`

```bash
atlas migrate new add_initial_data
```

2. Add manual script into the file: Check `migrations/20230319162418_add_initial_data.sql`

```sql
insert into testschema.testtable (id, name, description, test_array_of_array, test_array_of_int) values ('test_id_1', 'test1', 'test1', '{{1,2,3},{4,5,6}}', '{1,2,3}');
insert into testschema.testtable (id, name, description, test_array_of_array, test_array_of_int) values ('test_id_2', 'test2', 'test2', '{{7,8,9},{10,11,12}}', '{4,5,6}');
insert into testschema.testtable (id, name, description, test_array_of_array, test_array_of_int) values ('test_id_3', 'test3', 'test3', '{{13,14,15},{16,17,18}}', '{7,8,9}');

REFRESH MATERIALIZED VIEW testschema.test_materialized_view;

```

3. Refresh hash with `atlas migrate hash`

## Apply it from scrach

Use `schema/establish.sh`