-- Create "model_db" table
CREATE TABLE "testschema"."model_db" (
  "model_name" character varying(16) NOT NULL,
  "db_type" character varying(16) NOT NULL,
  "version" character varying(32) NOT NULL,
  "name" character varying(32) NOT NULL,
  "data" text NOT NULL,
  PRIMARY KEY ("model_name", "db_type", "version")
);
-- Create "model_db_signal" table
CREATE TABLE "testschema"."model_db_signal" (
  "model_name" character varying(16) NOT NULL,
  "db_type" character varying(16) NOT NULL,
  "version" character varying(32) NOT NULL,
  "signal_name" text NOT NULL,
  "sig_id" integer NOT NULL,
  "msg_name" text NOT NULL,
  "factor" double precision NOT NULL,
  "signal_offset" double precision NOT NULL,
  PRIMARY KEY ("model_name", "db_type", "version", "signal_name"),
  CONSTRAINT "model_db_signal_model_name_db_type_version_fkey" FOREIGN KEY ("model_name", "db_type", "version") REFERENCES "testschema"."model_db" ("model_name", "db_type", "version") ON UPDATE NO ACTION ON DELETE NO ACTION
);
