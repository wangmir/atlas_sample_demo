-- Add new schema named "testschema"
CREATE SCHEMA "testschema";
-- Create "testtable" table
CREATE TABLE "testschema"."testtable" ("id" character varying(32) NOT NULL, "name" character varying(255) NOT NULL, "description" character varying(255) NOT NULL, "test_array_of_array" integer[] NULL, "test_array_of_int" integer[] NULL, PRIMARY KEY ("id"));
-- Create index "testtable_name_idx" to table: "testtable"
CREATE INDEX "testtable_name_idx" ON "testschema"."testtable" ("name");
