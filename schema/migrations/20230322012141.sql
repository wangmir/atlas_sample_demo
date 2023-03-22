-- Modify "test_new_composite_table" table
ALTER TABLE "testschema"."test_new_composite_table" DROP COLUMN "sample_column_1", ADD COLUMN "sample_column_2" character varying(255) NOT NULL, DROP CONSTRAINT "test_new_composite_table_pkey" , ADD PRIMARY KEY ("name", "sample_column_2");
