CREATE DATABASE test;
CREATE USER testuser WITH ENCRYPTED PASSWORD 'test1234';
GRANT ALL PRIVILEGES ON DATABASE test to testuser;