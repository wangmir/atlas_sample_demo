insert into testschema.testtable (id, name, description, test_array_of_array, test_array_of_int) values ('test_id_1', 'test1', 'test1', '{{1,2,3},{4,5,6}}', '{1,2,3}');
insert into testschema.testtable (id, name, description, test_array_of_array, test_array_of_int) values ('test_id_2', 'test2', 'test2', '{{7,8,9},{10,11,12}}', '{4,5,6}');
insert into testschema.testtable (id, name, description, test_array_of_array, test_array_of_int) values ('test_id_3', 'test3', 'test3', '{{13,14,15},{16,17,18}}', '{7,8,9}');

REFRESH MATERIALIZED VIEW testschema.test_materialized_view;