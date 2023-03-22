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
    null = false
    type = character_varying(255)
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
    type = character_varying (32)
  }
  column "name" {
    null = false
    type = character_varying (255)
  }
  column "sample_new_column" {
    null = false
    type = character_varying (255)
    default = "default_value_sample_new_column"
  }
  column "testtable_id" {
    null = false
    type = character_varying (32)
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
    type = character_varying (255)
  }
  column "sample_column_2" {
    null = false
    type = character_varying (255)
  }

  primary_key {
    columns = [column.name, column.sample_column_2]
  }
}

schema "public" {
}
schema "testschema" {
}
