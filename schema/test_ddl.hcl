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
  column "test_array_of_array" {
    null = true
    type = sql("integer[]")
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
schema "public" {
}
schema "testschema" {
}
