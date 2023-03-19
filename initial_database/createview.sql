CREATE MATERIALIZED VIEW testschema.test_materialized_view AS
SELECT
    CONCAT(t.id, t.name, t.description) AS t_data,
    NOW() AS t_time
FROM
    testschema.testtable AS t;