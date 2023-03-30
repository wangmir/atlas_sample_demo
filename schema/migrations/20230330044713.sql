-- Modify "test_new_composite_table" table
ALTER TABLE "testschema"."test_new_composite_table" ADD COLUMN "sample_column_2" character varying(255) NOT NULL DEFAULT 'test_default', ADD COLUMN "sample_column_3" character varying(255) NULL;
-- Create "test_new_composite_table1" table
CREATE TABLE "testschema"."test_new_composite_table1" (
  "name" character varying(255) NOT NULL,
  "sample_column_1" character varying(255) NOT NULL,
  "sample_column_2" character varying(255) NOT NULL DEFAULT 'test_default',
  "sample_column_3" character varying(255) NULL,
  PRIMARY KEY ("name", "sample_column_1")
);
