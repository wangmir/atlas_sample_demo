CREATE TABLE IF NOT EXISTS testschema.testtable (
    id VARCHAR(32) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description VARCHAR(255) NOT NULL,
    test_array_of_array INTEGER[][],
    test_array_of_int INTEGER[]
);
