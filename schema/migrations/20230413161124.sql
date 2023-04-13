-- Drop "model_db" table
DROP TABLE "testschema"."model_db";
-- Modify "model_db_signal" table
ALTER TABLE "testschema"."model_db_signal" DROP CONSTRAINT "model_db_signal_model_name_db_type_version_fkey";
