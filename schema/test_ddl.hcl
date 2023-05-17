table "testtable" {
  schema = schema.testschema
  column "id" {
    null = false
    type = character_varying(32)
  }
  column "name" {
    null = false
    type = character_varying(255)
  }
  column "description" {
    null = false
    type = character_varying(255)
  }
  column "new_field" {
    null    = false
    type    = character_varying(255)
    default = "default_value_new_field"
  }
  column "test_array_of_array" {
    null = true
    type = sql("integer[][]")
  }
  column "test_array_of_int" {
    null = true
    type = sql("integer[]")
  }
  primary_key {
    columns = [column.id]
  }
  index "testtable_name_idx" {
    columns = [column.name]
  }
}

table "test_new_table" {
  schema = schema.testschema
  column "id" {
    null = false
    type = character_varying(32)
  }
  column "name" {
    null = false
    type = character_varying(255)
  }
  column "sample_new_column" {
    null    = false
    type    = character_varying(255)
    default = "default_value_sample_new_column"
  }
  column "testtable_id" {
    null = false
    type = character_varying(32)
  }

  primary_key {
    columns = [column.id]
  }

  foreign_key "testtable_id" {
    columns     = [column.testtable_id]
    ref_columns = [table.testtable.column.id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }
}

table "test_new_composite_table" {
  schema = schema.testschema
  column "name" {
    null = false
    type = character_varying(255)
  }
  column "sample_column_1" {
    null = false
    type = character_varying(255)
  }

  column "sample_column_2" {
    null    = false
    type    = character_varying(255)
    default = "test_default"
  }

  column "sample_column_3" {
    null = true
    type = character_varying(255)
  }

  primary_key {
    columns = [column.name, column.sample_column_1]
  }
}
table "model_db" {
  schema = schema.testschema
  column "model_name" {
    null = false
    type = character_varying(16)
  }
  column "db_type" {
    null = false
    type = character_varying(16)
  }
  column "version" {
    null = false
    type = character_varying(32)
  }
  column "name" {
    null = false
    type = character_varying(32)
  }
  column "data" {
    null = false
    type = text
  }
  primary_key {
    columns = [column.model_name, column.db_type, column.version]
  }
}
table "model_db_signal" {
  schema = schema.testschema
  column "model_name" {
    null = false
    type = character_varying(16)
  }
  column "db_type" {
    null = false
    type = character_varying(16)
  }
  column "version" {
    null = false
    type = character_varying(32)
  }
  column "signal_name" {
    null = false
    type = text
  }
  column "sig_id" {
    null = false
    type = integer
  }
  column "msg_name" {
    null = false
    type = text
  }
  column "factor" {
    null = false
    type = double_precision
  }
  column "signal_offset" {
    null = false
    type = double_precision
  }
  primary_key {
    columns = [column.model_name, column.db_type, column.version, column.signal_name]
  }
  foreign_key "model_db_signal_model_name_db_type_version_fkey" {
    columns     = [column.model_name, column.version, column.db_type]
    ref_columns = [table.model_db.column.model_name, table.model_db.column.version, table.model_db.column.db_type]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
}


schema "public" {
}
schema "testschema" {
}
