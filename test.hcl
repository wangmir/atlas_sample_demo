table "apn" {
  schema = schema.vdata
  column "name" {
    null = false
    type = character_varying(32)
  }
  column "model_name" {
    null = false
    type = character_varying(16)
  }
  column "tx_field_name" {
    null = false
    type = character_varying(64)
  }
  column "rx_field_name" {
    null = false
    type = character_varying(64)
  }
  column "created_by" {
    null = false
    type = character_varying(32)
  }
  column "creation_time" {
    null = false
    type = timestamptz
  }
  column "modified_by" {
    null = true
    type = character_varying(32)
  }
  column "modification_time" {
    null = true
    type = timestamptz
  }
  primary_key {
    columns = [column.name, column.model_name]
  }
  foreign_key "apn_created_by_fkey" {
    columns     = [column.created_by]
    ref_columns = [table.user.column.user_id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  foreign_key "apn_modified_by_fkey" {
    columns     = [column.modified_by]
    ref_columns = [table.user.column.user_id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
}
table "block_ips" {
  schema = schema.vdata
  column "vehicle_id" {
    null = false
    type = character_varying(36)
  }
  column "block_ips" {
    null = true
    type = sql("character varying(32)[]")
  }
  primary_key {
    columns = [column.vehicle_id]
  }
  foreign_key "block_ips_vehicle_id_fkey" {
    columns     = [column.vehicle_id]
    ref_columns = [table.vin_vehicle_id.column.vehicle_id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }
}
table "can_msgs_capture" {
  schema = schema.vdata
  column "policy_id" {
    null = false
    type = character_varying(36)
  }
  column "trigger_policy_id" {
    null = false
    type = integer
  }
  column "names" {
    null = false
    type = sql("text[]")
  }
  column "sample_interval" {
    null = false
    type = integer
  }
  column "duration_before_start" {
    null = true
    type = integer
  }
  primary_key {
    columns = [column.policy_id, column.trigger_policy_id]
  }
  foreign_key "can_msgs_capture_policy_id_fkey" {
    columns     = [column.policy_id]
    ref_columns = [table.policy.column.policy_id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }
  foreign_key "can_msgs_capture_trigger_policy_id_fkey" {
    columns     = [column.trigger_policy_id]
    ref_columns = [table.trigger_policy.column.trigger_policy_id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
}
table "capture" {
  schema = schema.vdata
  column "policy_id" {
    null = false
    type = character_varying(36)
  }
  column "trigger_policy_id" {
    null = false
    type = integer
  }
  column "raw_json" {
    null = false
    type = json
  }
  primary_key {
    columns = [column.policy_id, column.trigger_policy_id]
  }
  foreign_key "capture_policy_id_fkey" {
    columns     = [column.policy_id]
    ref_columns = [table.policy.column.policy_id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }
  foreign_key "capture_trigger_policy_id_fkey" {
    columns     = [column.trigger_policy_id]
    ref_columns = [table.trigger_policy.column.trigger_policy_id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
}
table "cleanup_schedule" {
  schema = schema.vdata
  column "target" {
    null = false
    type = character_varying(50)
  }
  column "duration" {
    null = false
    type = integer
  }
  column "creation_time" {
    null = false
    type = timestamptz
  }
  column "created_by" {
    null = false
    type = character_varying(32)
  }
  column "modification_time" {
    null = true
    type = timestamptz
  }
  column "modified_by" {
    null = true
    type = character_varying(32)
  }
  primary_key {
    columns = [column.target]
  }
  foreign_key "cleanup_schedule_created_by_fkey" {
    columns     = [column.created_by]
    ref_columns = [table.user.column.user_id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  foreign_key "cleanup_schedule_modified_by_fkey" {
    columns     = [column.modified_by]
    ref_columns = [table.user.column.user_id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
}
table "cmd_capture" {
  schema = schema.vdata
  column "policy_id" {
    null = false
    type = character_varying(36)
  }
  column "trigger_policy_id" {
    null = false
    type = integer
  }
  column "ls" {
    null = false
    type = sql("character varying(20)[]")
  }
  primary_key {
    columns = [column.policy_id, column.trigger_policy_id]
  }
  foreign_key "cmd_capture_policy_id_fkey" {
    columns     = [column.policy_id]
    ref_columns = [table.policy.column.policy_id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }
  foreign_key "cmd_capture_trigger_policy_id_fkey" {
    columns     = [column.trigger_policy_id]
    ref_columns = [table.trigger_policy.column.trigger_policy_id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
}
table "config" {
  schema = schema.vdata
  column "config_type" {
    null = false
    type = character_varying(16)
  }
  column "name" {
    null = false
    type = character_varying(32)
  }
  column "value" {
    null = false
    type = character_varying(128)
  }
  primary_key {
    columns = [column.config_type, column.name]
  }
}
table "data_cap_action" {
  schema = schema.vdata
  column "action_id" {
    null = false
    type = character_varying(36)
  }
  column "sg_name" {
    null = false
    type = character_varying(36)
  }
  column "threshold" {
    null = false
    type = double_precision
  }
  column "persistent_policy_ids" {
    null = true
    type = sql("character varying(36)[]")
  }
  column "streaming_policy_ids" {
    null = true
    type = sql("character varying(36)[]")
  }
  primary_key {
    columns = [column.action_id]
  }
}
table "data_cap_config" {
  schema = schema.vdata
  column "config_id" {
    null = false
    type = character_varying(36)
  }
  column "name" {
    null = false
    type = character_varying(64)
  }
  column "version" {
    null = false
    type = integer
  }
  column "data_limit" {
    null = false
    type = integer
  }
  column "model_name" {
    null = false
    type = character_varying(16)
  }
  column "action_ids" {
    null = false
    type = sql("character varying(36)[]")
  }
  column "created_by" {
    null = false
    type = character_varying(32)
  }
  column "creation_time" {
    null = false
    type = timestamptz
  }
  column "disabled" {
    null    = true
    type    = boolean
    default = false
  }
  column "disabled_by" {
    null = true
    type = character_varying(32)
  }
  column "enabled_by" {
    null = true
    type = character_varying(32)
  }
  column "modification_time" {
    null = true
    type = timestamptz
  }
  primary_key {
    columns = [column.config_id]
  }
  foreign_key "data_cap_config_created_by_fkey" {
    columns     = [column.created_by]
    ref_columns = [table.user.column.user_id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  foreign_key "data_cap_config_disabled_by_fkey" {
    columns     = [column.disabled_by]
    ref_columns = [table.user.column.user_id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  foreign_key "data_cap_config_enabled_by_fkey" {
    columns     = [column.enabled_by]
    ref_columns = [table.user.column.user_id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  index "data_cap_config_name_version_key" {
    unique  = true
    columns = [column.name, column.version]
  }
}
table "data_cap_deployment" {
  schema = schema.vdata
  column "deployment_id" {
    null = false
    type = character_varying(36)
  }
  column "config_id" {
    null = false
    type = character_varying(36)
  }
  column "state" {
    null = false
    type = character_varying(10)
  }
  column "deploy_time" {
    null = false
    type = timestamptz
  }
  column "deployed_by" {
    null = false
    type = character_varying(32)
  }
  column "inactive_time" {
    null = true
    type = timestamptz
  }
  column "vehicle_filter_id" {
    null = false
    type = character_varying(36)
  }
  primary_key {
    columns = [column.deployment_id]
  }
  foreign_key "data_cap_deployment_config_id_fkey" {
    columns     = [column.config_id]
    ref_columns = [table.data_cap_config.column.config_id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  foreign_key "data_cap_deployment_deployed_by_fkey" {
    columns     = [column.deployed_by]
    ref_columns = [table.user.column.user_id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  foreign_key "data_cap_deployment_vehicle_filter_id_fkey" {
    columns     = [column.vehicle_filter_id]
    ref_columns = [table.fleet.column.name]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
}
table "dlt_message" {
  schema = schema.vdata
  column "log_filtering_id" {
    null = false
    type = character_varying(36)
  }
  column "app_id" {
    null = false
    type = character_varying(10)
  }
  column "dlt_text" {
    null = false
    type = bytea
  }
  column "event_time" {
    null = false
    type = character_varying(30)
  }
  primary_key {
    columns = [column.log_filtering_id, column.app_id, column.event_time]
  }
  foreign_key "dlt_message_log_filtering_id_fkey" {
    columns     = [column.log_filtering_id]
    ref_columns = [table.log_filtering.column.log_filtering_id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
}
table "download_request" {
  schema = schema.vdata
  column "request_id" {
    null = false
    type = character_varying(36)
  }
  column "file_id" {
    null = true
    type = character_varying(36)
  }
  column "vehicle_id" {
    null = true
    type = character_varying(36)
  }
  column "policy_id" {
    null = true
    type = character_varying(36)
  }
  column "trigger_policy_id" {
    null = true
    type = integer
  }
  column "from_time" {
    null = false
    type = timestamptz
  }
  column "to_time" {
    null = false
    type = timestamptz
  }
  column "num_data_records" {
    null    = false
    type    = integer
    default = 0
  }
  column "total_size_data_records" {
    null    = false
    type    = double_precision
    default = 0
  }
  column "num_images" {
    null    = false
    type    = integer
    default = 0
  }
  column "total_size_images" {
    null    = false
    type    = double_precision
    default = 0
  }
  column "checksum" {
    null = true
    type = character_varying(64)
  }
  column "state" {
    null = true
    type = character_varying(32)
  }
  column "error_msg" {
    null = true
    type = character_varying(512)
  }
  column "created_by" {
    null = false
    type = character_varying(256)
  }
  column "creation_time" {
    null = false
    type = timestamptz
  }
  primary_key {
    columns = [column.request_id]
  }
  foreign_key "download_request_created_by_fkey" {
    columns     = [column.created_by]
    ref_columns = [table.user.column.user_id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  foreign_key "download_request_policy_id_fkey" {
    columns     = [column.policy_id]
    ref_columns = [table.policy.column.policy_id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }
  foreign_key "download_request_vehicle_id_fkey" {
    columns     = [column.vehicle_id]
    ref_columns = [table.vin_vehicle_id.column.vehicle_id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }
}
table "ecu_diagnostics_capture" {
  schema = schema.vdata
  column "policy_id" {
    null = false
    type = character_varying(36)
  }
  column "trigger_policy_id" {
    null = false
    type = integer
  }
  column "max_retries" {
    null = false
    type = integer
  }
  column "retry_interval" {
    null = false
    type = integer
  }
  column "uds" {
    null = false
    type = text
  }
  column "loop_count" {
    null = false
    type = integer
  }
  column "sample_interval" {
    null = true
    type = integer
  }
  primary_key {
    columns = [column.policy_id, column.trigger_policy_id]
  }
  foreign_key "ecu_diagnostics_capture_policy_id_fkey" {
    columns     = [column.policy_id]
    ref_columns = [table.policy.column.policy_id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }
  foreign_key "ecu_diagnostics_capture_trigger_policy_id_fkey" {
    columns     = [column.trigger_policy_id]
    ref_columns = [table.trigger_policy.column.trigger_policy_id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
}
table "engine_type" {
  schema = schema.vdata
  column "engine_type_id" {
    null = false
    type = integer
  }
  column "name" {
    null = false
    type = character_varying(32)
  }
  column "description" {
    null = true
    type = character_varying(64)
  }
  primary_key {
    columns = [column.engine_type_id]
  }
  index "engine_type_name_key" {
    unique  = true
    columns = [column.name]
  }
}
table "eth_stat_capture" {
  schema = schema.vdata
  column "policy_id" {
    null = false
    type = character_varying(36)
  }
  column "trigger_policy_id" {
    null = false
    type = integer
  }
  column "switch_stats" {
    null = false
    type = text
  }
  column "sample_interval" {
    null = false
    type = integer
  }
  primary_key {
    columns = [column.policy_id, column.trigger_policy_id]
  }
  foreign_key "eth_stat_capture_policy_id_fkey" {
    columns     = [column.policy_id]
    ref_columns = [table.policy.column.policy_id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }
  foreign_key "eth_stat_capture_trigger_policy_id_fkey" {
    columns     = [column.trigger_policy_id]
    ref_columns = [table.trigger_policy.column.trigger_policy_id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
}
table "event_info_capture" {
  schema = schema.vdata
  column "policy_id" {
    null = false
    type = character_varying(36)
  }
  column "trigger_policy_id" {
    null = false
    type = integer
  }
  column "targets" {
    null = false
    type = text
  }
  column "duration_before_start" {
    null = true
    type = integer
  }
  primary_key {
    columns = [column.policy_id, column.trigger_policy_id]
  }
  foreign_key "event_info_capture_policy_id_fkey" {
    columns     = [column.policy_id]
    ref_columns = [table.policy.column.policy_id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }
  foreign_key "event_info_capture_trigger_policy_id_fkey" {
    columns     = [column.trigger_policy_id]
    ref_columns = [table.trigger_policy.column.trigger_policy_id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
}
table "file_attributes" {
  schema = schema.vdata
  column "file_id" {
    null = false
    type = character_varying(36)
  }
  column "file_name" {
    null = false
    type = character_varying(256)
  }
  column "file_size" {
    null = false
    type = integer
  }
  column "file_type" {
    null = false
    type = character_varying(10)
  }
  column "last_modified_time" {
    null = false
    type = timestamptz
  }
  primary_key {
    columns = [column.file_id]
  }
}
table "file_metadata" {
  schema = schema.vdata
  column "file_id" {
    null = false
    type = character_varying(36)
  }
  column "file_name" {
    null = false
    type = character_varying(256)
  }
  column "vehicle_id" {
    null = false
    type = character_varying(36)
  }
  column "subtype" {
    null = false
    type = character_varying(32)
  }
  column "data_type" {
    null = false
    type = character_varying(64)
  }
  column "trace_id" {
    null = false
    type = character_varying(36)
  }
  column "file_size_in_byte" {
    null = false
    type = integer
  }
  column "last_modified_time" {
    null = false
    type = timestamptz
  }
  column "creation_time" {
    null = false
    type = timestamptz
  }
  primary_key {
    columns = [column.file_id]
  }
}
table "file_record" {
  schema = schema.vdata
  column "id" {
    null = false
    type = character_varying(36)
  }
  column "file_path" {
    null = false
    type = character_varying(256)
  }
  column "file_size" {
    null = false
    type = integer
  }
  column "file_type" {
    null = false
    type = character_varying(10)
  }
  column "creation_time" {
    null = false
    type = timestamptz
  }
  column "last_modified_time" {
    null = false
    type = timestamptz
  }
  primary_key {
    columns = [column.id]
  }
}
table "files_capture" {
  schema = schema.vdata
  column "policy_id" {
    null = false
    type = character_varying(36)
  }
  column "trigger_policy_id" {
    null = false
    type = integer
  }
  column "file_paths" {
    null = true
    type = sql("text[]")
  }
  column "directory_paths" {
    null = true
    type = sql("text[]")
  }
  column "wildcards" {
    null = true
    type = sql("text[]")
  }
  column "sample_interval" {
    null = false
    type = integer
  }
  primary_key {
    columns = [column.policy_id, column.trigger_policy_id]
  }
  foreign_key "files_capture_policy_id_fkey" {
    columns     = [column.policy_id]
    ref_columns = [table.policy.column.policy_id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }
  foreign_key "files_capture_trigger_policy_id_fkey" {
    columns     = [column.trigger_policy_id]
    ref_columns = [table.trigger_policy.column.trigger_policy_id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
}
table "fleet" {
  schema = schema.vdata
  column "name" {
    null = false
    type = character_varying(40)
  }
  column "type" {
    null = false
    type = character_varying(32)
  }
  column "description" {
    null = true
    type = character_varying(128)
  }
  column "created_by" {
    null = false
    type = character_varying(32)
  }
  column "creation_time" {
    null = false
    type = timestamptz
  }
  column "modification_time" {
    null = false
    type = timestamptz
  }
  column "disabled" {
    null = false
    type = boolean
  }
  column "exclude_vehicle_ids" {
    null = true
    type = sql("character varying(36)[]")
  }
  column "use_attributes" {
    null = false
    type = boolean
  }
  column "fleet_names" {
    null = true
    type = sql("character varying(40)[]")
  }
  column "engine_type_ids" {
    null = true
    type = sql("integer[]")
  }
  column "model_names" {
    null = true
    type = sql("character varying(16)[]")
  }
  column "can_db_versions" {
    null = true
    type = sql("character varying(32)[]")
  }
  column "eth_db_versions" {
    null = true
    type = sql("character varying(32)[]")
  }
  column "tags_operator" {
    null = true
    type = character_varying(5)
  }
  column "tags" {
    null = true
    type = sql("text[]")
  }
  primary_key {
    columns = [column.name]
  }
  foreign_key "fleet_created_by_fkey" {
    columns     = [column.created_by]
    ref_columns = [table.user.column.user_id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  index "fleet_name_type_idx" {
    columns = [column.name, column.type]
  }
}
table "fleet_vehicle_id" {
  schema = schema.vdata
  column "fleet_name" {
    null = false
    type = character_varying(40)
  }
  column "vehicle_id" {
    null = false
    type = character_varying(36)
  }
  primary_key {
    columns = [column.fleet_name, column.vehicle_id]
  }
  foreign_key "fleet_vehicle_id_fleet_name_fkey" {
    columns     = [column.fleet_name]
    ref_columns = [table.fleet.column.name]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  foreign_key "fleet_vehicle_id_vehicle_id_fkey" {
    columns     = [column.vehicle_id]
    ref_columns = [table.vin_vehicle_id.column.vehicle_id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }
}
table "identity_role" {
  schema = schema.vdata
  column "platform" {
    null = false
    type = character_varying(16)
  }
  column "name" {
    null = false
    type = character_varying(64)
  }
  column "description" {
    null = true
    type = character_varying(256)
  }
  column "is_predefined" {
    null = false
    type = boolean
  }
  column "is_disabled" {
    null = false
    type = boolean
  }
  column "allowed_actions" {
    null = false
    type = sql("character varying(16)[]")
  }
  column "condition" {
    null = true
    type = json
  }
  column "creation_time" {
    null = false
    type = timestamptz
  }
  column "modification_time" {
    null = false
    type = timestamptz
  }
  primary_key {
    columns = [column.platform, column.name]
  }
  index "identity_role_creation_time_platform_name_idx" {
    columns = [column.creation_time, column.platform, column.name]
  }
  index "identity_role_modification_time_platform_name_idx" {
    columns = [column.modification_time, column.platform, column.name]
  }
  index "identity_role_name_platform_idx" {
    columns = [column.name, column.platform]
  }
}
table "incident_comment" {
  schema = schema.vdata
  column "comment_id" {
    null = false
    type = character_varying(36)
  }
  column "incident_id" {
    null = false
    type = character_varying(36)
  }
  column "commenter" {
    null = false
    type = character_varying(32)
  }
  column "creation_time" {
    null = false
    type = timestamptz
  }
  column "comment" {
    null = false
    type = text
  }
  primary_key {
    columns = [column.comment_id]
  }
  foreign_key "incident_comment_commenter_fkey" {
    columns     = [column.commenter]
    ref_columns = [table.user.column.user_id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  foreign_key "incident_comment_incident_id_fkey" {
    columns     = [column.incident_id]
    ref_columns = [table.vehicle_security_incident.column.incident_id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }
}
table "location_capture" {
  schema = schema.vdata
  column "policy_id" {
    null = false
    type = character_varying(36)
  }
  column "trigger_policy_id" {
    null = false
    type = integer
  }
  column "sample_interval" {
    null = false
    type = integer
  }
  column "duration_before_start" {
    null = true
    type = integer
  }
  primary_key {
    columns = [column.policy_id, column.trigger_policy_id]
  }
  foreign_key "location_capture_policy_id_fkey" {
    columns     = [column.policy_id]
    ref_columns = [table.policy.column.policy_id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }
  foreign_key "location_capture_trigger_policy_id_fkey" {
    columns     = [column.trigger_policy_id]
    ref_columns = [table.trigger_policy.column.trigger_policy_id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
}
table "location_data_record_grafana" {
  schema = schema.vdata
  column "vehicle_id" {
    null = false
    type = character_varying(36)
  }
  column "policy_id" {
    null = false
    type = character_varying(36)
  }
  column "trigger_policy_ids" {
    null = true
    type = sql("integer[]")
  }
  column "latitude" {
    null = false
    type = double_precision
  }
  column "longitude" {
    null = false
    type = double_precision
  }
  column "time" {
    null    = true
    type    = timestamptz
    default = sql("CURRENT_TIMESTAMP")
  }
  index "location_data_record_grafana_time_vehicle_id_policy_id_trig_idx" {
    columns = [column.time, column.vehicle_id, column.policy_id, column.trigger_policy_ids]
  }
}
table "log_file_attributes_capture" {
  schema = schema.vdata
  column "policy_id" {
    null = false
    type = character_varying(36)
  }
  column "trigger_policy_id" {
    null = false
    type = integer
  }
  column "value" {
    null = false
    type = text
  }
  primary_key {
    columns = [column.policy_id, column.trigger_policy_id]
  }
  foreign_key "log_file_attributes_capture_policy_id_fkey" {
    columns     = [column.policy_id]
    ref_columns = [table.policy.column.policy_id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }
  foreign_key "log_file_attributes_capture_trigger_policy_id_fkey" {
    columns     = [column.trigger_policy_id]
    ref_columns = [table.trigger_policy.column.trigger_policy_id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
}
table "log_filtering" {
  schema = schema.vdata
  column "log_filtering_id" {
    null = false
    type = character_varying(36)
  }
  column "vehicle_id" {
    null = false
    type = character_varying(36)
  }
  column "file_types" {
    null = false
    type = sql("character varying(10)[]")
  }
  column "from_time" {
    null = true
    type = timestamptz
  }
  column "to_time" {
    null = true
    type = timestamptz
  }
  column "file_ids_to_capture" {
    null = true
    type = sql("character varying(36)[]")
  }
  column "max_wait_time" {
    null = false
    type = integer
  }
  column "created_by" {
    null = false
    type = character_varying(256)
  }
  column "file_attribute_policy_id" {
    null = true
    type = character_varying(36)
  }
  column "file_capture_policy_id" {
    null = true
    type = character_varying(36)
  }
  column "file_names_captured" {
    null = true
    type = sql("character varying(256)[]")
  }
  column "num_files_expected" {
    null = true
    type = integer
  }
  column "total_captured_file_size" {
    null = true
    type = integer
  }
  column "on_vehicle_file_ids" {
    null = true
    type = sql("character varying(36)[]")
  }
  column "processed_file_ids" {
    null = true
    type = sql("character varying(36)[]")
  }
  column "captured_file_ids" {
    null = true
    type = sql("character varying(36)[]")
  }
  column "app_ids" {
    null = true
    type = sql("character varying(10)[]")
  }
  column "state" {
    null = true
    type = integer
  }
  column "error_msg" {
    null = true
    type = character_varying(512)
  }
  column "file_capture_time" {
    null = true
    type = timestamptz
  }
  column "creation_time" {
    null = false
    type = timestamptz
  }
  primary_key {
    columns = [column.log_filtering_id]
  }
  foreign_key "log_filtering_created_by_fkey" {
    columns     = [column.created_by]
    ref_columns = [table.user.column.user_id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  foreign_key "log_filtering_file_attribute_policy_id_fkey" {
    columns     = [column.file_attribute_policy_id]
    ref_columns = [table.policy.column.policy_id]
    on_update   = CASCADE
    on_delete   = CASCADE
  }
  foreign_key "log_filtering_file_capture_policy_id_fkey" {
    columns     = [column.file_capture_policy_id]
    ref_columns = [table.policy.column.policy_id]
    on_update   = CASCADE
    on_delete   = CASCADE
  }
  foreign_key "log_filtering_vehicle_id_fkey" {
    columns     = [column.vehicle_id]
    ref_columns = [table.vin_vehicle_id.column.vehicle_id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }
}
table "media_events_capture" {
  schema = schema.vdata
  column "policy_id" {
    null = false
    type = character_varying(36)
  }
  column "trigger_policy_id" {
    null = false
    type = integer
  }
  column "targets" {
    null = false
    type = text
  }
  column "duration_before_start" {
    null = true
    type = integer
  }
  primary_key {
    columns = [column.policy_id, column.trigger_policy_id]
  }
  foreign_key "media_events_capture_policy_id_fkey" {
    columns     = [column.policy_id]
    ref_columns = [table.policy.column.policy_id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }
  foreign_key "media_events_capture_trigger_policy_id_fkey" {
    columns     = [column.trigger_policy_id]
    ref_columns = [table.trigger_policy.column.trigger_policy_id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
}
table "merged_policy_subpolicy" {
  schema = schema.vdata
  column "policy_id" {
    null = false
    type = character_varying(36)
  }
  column "subpolicy_id" {
    null = false
    type = character_varying(36)
  }
  primary_key {
    columns = [column.policy_id, column.subpolicy_id]
  }
  foreign_key "merged_policy_subpolicy_policy_id_fkey" {
    columns     = [column.policy_id]
    ref_columns = [table.policy.column.policy_id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }
  foreign_key "merged_policy_subpolicy_subpolicy_id_fkey" {
    columns     = [column.subpolicy_id]
    ref_columns = [table.policy.column.policy_id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }
}
table "model" {
  schema = schema.vdata
  column "model_name" {
    null = false
    type = character_varying(16)
  }
  column "model_years" {
    null = false
    type = sql("integer[]")
  }
  column "can_db_version" {
    null = false
    type = character_varying(32)
  }
  column "eth_db_version" {
    null = false
    type = character_varying(32)
  }
  column "nss_share_capacity" {
    null = true
    type = integer
  }
  primary_key {
    columns = [column.model_name, column.can_db_version, column.eth_db_version]
  }
}
table "model_db" {
  schema = schema.vdata
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
  schema = schema.vdata
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
    columns     = [column.model_name, column.db_type, column.version]
    ref_columns = [table.model_db.column.model_name, table.model_db.column.db_type, table.model_db.column.version]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
}
table "network_data_record_grafana" {
  schema = schema.vdata
  column "vehicle_id" {
    null = false
    type = character_varying(36)
  }
  column "policy_id" {
    null = false
    type = character_varying(36)
  }
  column "trigger_policy_ids" {
    null = true
    type = sql("integer[]")
  }
  column "bus_id" {
    null = false
    type = character_varying(36)
  }
  column "data_type" {
    null = false
    type = character_varying(24)
  }
  column "network_name" {
    null = true
    type = character_varying(36)
  }
  column "msg_id" {
    null = false
    type = character_varying(36)
  }
  column "msg_name" {
    null = false
    type = character_varying(36)
  }
  column "signal_id" {
    null = false
    type = character_varying(36)
  }
  column "signal_name" {
    null = false
    type = character_varying(36)
  }
  column "value" {
    null = true
    type = double_precision
  }
  column "time" {
    null    = true
    type    = timestamptz
    default = sql("CURRENT_TIMESTAMP")
  }
  index "network_data_record_grafana_time_vehicle_id_policy_id_trigg_idx" {
    columns = [column.time, column.vehicle_id, column.policy_id, column.trigger_policy_ids, column.signal_id]
  }
}
table "nss_client" {
  schema = schema.vdata
  column "model_name" {
    null = false
    type = character_varying(16)
  }
  column "name" {
    null = false
    type = character_varying(16)
  }
  column "ip" {
    null = false
    type = character_varying(16)
  }
  primary_key {
    columns = [column.model_name, column.name]
  }
}
table "nss_client_stat" {
  schema = schema.vdata
  column "client_id" {
    null = false
    type = character_varying(36)
  }
  column "stat_id" {
    null = false
    type = character_varying(36)
  }
  column "client_ip" {
    null = false
    type = character_varying(16)
  }
  column "share" {
    null = false
    type = character_varying(32)
  }
  column "mount_point" {
    null = false
    type = character_varying(32)
  }
  column "ops_per_s" {
    null = false
    type = double_precision
  }
  column "rpc_bklog" {
    null = false
    type = double_precision
  }
  column "read_ops_per_s" {
    null = false
    type = double_precision
  }
  column "read_kb_per_s" {
    null = false
    type = double_precision
  }
  column "read_kb_per_op" {
    null = false
    type = double_precision
  }
  column "read_retrans" {
    null = false
    type = character_varying(10)
  }
  column "read_avg_rt_tin_ms" {
    null = false
    type = double_precision
  }
  column "read_avg_exe_in_ms" {
    null = false
    type = double_precision
  }
  column "write_ops_per_s" {
    null = false
    type = double_precision
  }
  column "write_kb_per_s" {
    null = false
    type = double_precision
  }
  column "write_kb_per_op" {
    null = false
    type = double_precision
  }
  column "write_retrans" {
    null = false
    type = character_varying(10)
  }
  column "write_avg_rt_tin_ms" {
    null = false
    type = double_precision
  }
  column "write_avg_exein_ms" {
    null = false
    type = double_precision
  }
  primary_key {
    columns = [column.client_id]
  }
  foreign_key "nss_client_stat_stat_id_fkey" {
    columns     = [column.stat_id]
    ref_columns = [table.nss_stat.column.stat_id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  index "nss_client_stat_stat_id_idx" {
    columns = [column.stat_id]
  }
}
table "nss_group" {
  schema = schema.vdata
  column "model_name" {
    null = false
    type = character_varying(16)
  }
  column "name" {
    null = false
    type = character_varying(16)
  }
  column "gid" {
    null = false
    type = integer
  }
  column "uids" {
    null = false
    type = sql("integer[]")
  }
  primary_key {
    columns = [column.model_name, column.name]
  }
}
table "nss_stat" {
  schema = schema.vdata
  column "stat_id" {
    null = false
    type = character_varying(36)
  }
  column "vehicle_id" {
    null = false
    type = character_varying(36)
  }
  column "packets" {
    null = false
    type = integer
  }
  column "packet_udp" {
    null = false
    type = integer
  }
  column "packet_tcp" {
    null = false
    type = integer
  }
  column "packet_tcpcon" {
    null = false
    type = integer
  }
  column "rpc_calls" {
    null = false
    type = integer
  }
  column "rpc_badcalls" {
    null = false
    type = integer
  }
  column "rpc_badfmt" {
    null = false
    type = integer
  }
  column "rpc_badauth" {
    null = false
    type = integer
  }
  column "rpc_badclnt" {
    null = false
    type = integer
  }
  column "io_read" {
    null = false
    type = double_precision
  }
  column "io_write" {
    null = false
    type = double_precision
  }
  column "system_nfsrunning" {
    null = false
    type = boolean
  }
  column "system_main_volume_operational" {
    null = false
    type = boolean
  }
  column "nvme_node" {
    null = false
    type = character_varying(16)
  }
  column "nvme_serial_number" {
    null = false
    type = character_varying(16)
  }
  column "nvme_model" {
    null = false
    type = character_varying(16)
  }
  column "nvme_namespace_id" {
    null = false
    type = character_varying(16)
  }
  column "nvme_firmware_rev" {
    null = false
    type = character_varying(16)
  }
  column "nvme_critical_warning" {
    null = false
    type = integer
  }
  column "nvme_temperature" {
    null = false
    type = character_varying(10)
  }
  column "nvme_available_spare" {
    null = false
    type = character_varying(10)
  }
  column "nvme_available_spare_threshold" {
    null = false
    type = character_varying(10)
  }
  column "nvme_percentage_used" {
    null = false
    type = character_varying(10)
  }
  column "nvme_endurance_group_critical_warning_summary" {
    null = false
    type = integer
  }
  column "nvme_data_units_read" {
    null = false
    type = integer
  }
  column "nvme_data_units_written" {
    null = false
    type = integer
  }
  column "nvme_host_read_commands" {
    null = false
    type = integer
  }
  column "nvme_host_write_commands" {
    null = false
    type = integer
  }
  column "nvme_controller_busy_time" {
    null = false
    type = integer
  }
  column "nvme_power_cycles" {
    null = false
    type = integer
  }
  column "nvme_power_on_hours" {
    null = false
    type = integer
  }
  column "nvme_unsafe_shutdowns" {
    null = false
    type = integer
  }
  column "nvme_media_errors" {
    null = false
    type = integer
  }
  column "nvme_num_err_log_entries" {
    null = false
    type = integer
  }
  column "nvme_warning_temperature_time" {
    null = false
    type = integer
  }
  column "nvme_critical_composite_temperature_time" {
    null = false
    type = integer
  }
  column "nvme_temperature_sensor1" {
    null = false
    type = character_varying(10)
  }
  column "nvme_thermal_management_t1_trans_count" {
    null = false
    type = integer
  }
  column "nvme_thermal_management_t2_trans_count" {
    null = false
    type = integer
  }
  column "nvme_thermal_management_t1_total_time" {
    null = false
    type = integer
  }
  column "nvme_thermal_management_t2_total_time" {
    null = false
    type = integer
  }
  column "raw_data" {
    null = false
    type = json
  }
  column "event_time" {
    null = false
    type = timestamptz
  }
  column "creation_time" {
    null    = true
    type    = timestamptz
    default = sql("CURRENT_TIMESTAMP")
  }
  primary_key {
    columns = [column.stat_id]
  }
  foreign_key "nss_stat_vehicle_id_fkey" {
    columns     = [column.vehicle_id]
    ref_columns = [table.vin_vehicle_id.column.vehicle_id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }
}
table "nss_system_share" {
  schema = schema.vdata
  column "share_id" {
    null = false
    type = character_varying(36)
  }
  column "stat_id" {
    null = false
    type = character_varying(36)
  }
  column "uuid" {
    null = false
    type = character_varying(36)
  }
  column "name" {
    null = false
    type = character_varying(32)
  }
  column "status" {
    null = false
    type = character_varying(16)
  }
  column "size" {
    null = false
    type = double_precision
  }
  column "used_space" {
    null = false
    type = double_precision
  }
  column "free_space" {
    null = false
    type = double_precision
  }
  column "encrypted" {
    null = false
    type = boolean
  }
  column "mount_point" {
    null = false
    type = character_varying(32)
  }
  column "is_mounted" {
    null = false
    type = boolean
  }
  column "directory_ids" {
    null = true
    type = sql("character varying(36)[]")
  }
  column "export_ids" {
    null = true
    type = sql("character varying(36)[]")
  }
  primary_key {
    columns = [column.share_id]
  }
  foreign_key "nss_system_share_stat_id_fkey" {
    columns     = [column.stat_id]
    ref_columns = [table.nss_stat.column.stat_id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  index "nss_system_share_stat_id_idx" {
    columns = [column.stat_id]
  }
}
table "nss_user" {
  schema = schema.vdata
  column "model_name" {
    null = false
    type = character_varying(16)
  }
  column "name" {
    null = false
    type = character_varying(32)
  }
  column "uid" {
    null = false
    type = integer
  }
  primary_key {
    columns = [column.model_name, column.name]
  }
}
table "policy" {
  schema = schema.vdata
  column "policy_id" {
    null = false
    type = character_varying(36)
  }
  column "category" {
    null = false
    type = character_varying(32)
  }
  column "name" {
    null = false
    type = character_varying(256)
  }
  column "use_case_names" {
    null = true
    type = sql("character varying(32)[]")
  }
  column "policy_type" {
    null = false
    type = character_varying(32)
  }
  column "subtype" {
    null = false
    type = character_varying(32)
  }
  column "version" {
    null = false
    type = integer
  }
  column "description" {
    null = true
    type = character_varying(256)
  }
  column "disabled" {
    null = false
    type = boolean
  }
  column "disabled_time" {
    null = true
    type = timestamptz
  }
  column "disabled_by" {
    null = false
    type = character_varying(32)
  }
  column "disabled_reason" {
    null = false
    type = character_varying(256)
  }
  column "model_name" {
    null = true
    type = character_varying(16)
  }
  column "model_years" {
    null = true
    type = sql("integer[]")
  }
  column "can_db_version" {
    null = true
    type = character_varying(32)
  }
  column "eth_db_version" {
    null = true
    type = character_varying(32)
  }
  column "engine_type" {
    null = true
    type = integer
  }
  column "created_by" {
    null = false
    type = character_varying(32)
  }
  column "creation_time" {
    null = false
    type = timestamptz
  }
  column "signing_state" {
    null = false
    type = integer
  }
  column "encrypted" {
    null = false
    type = boolean
  }
  column "data" {
    null = false
    type = json
  }
  column "raw_data" {
    null = false
    type = json
  }
  column "encrypted_data" {
    null = true
    type = text
  }
  column "data_checksum" {
    null = false
    type = character_varying(64)
  }
  column "encrypted_checksum" {
    null = false
    type = character_varying(64)
  }
  column "template" {
    null    = false
    type    = boolean
    default = false
  }
  primary_key {
    columns = [column.policy_id]
  }
  foreign_key "policy_created_by_fkey" {
    columns     = [column.created_by]
    ref_columns = [table.user.column.user_id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  index "policy_name_category_subtype_version_key" {
    unique  = true
    columns = [column.name, column.category, column.subtype, column.version]
  }
}
table "policy_data" {
  schema = schema.vdata
  column "policy_id" {
    null = false
    type = character_varying(36)
  }
  column "trigger_condition_ids" {
    null = true
    type = sql("integer[]")
  }
  column "trigger_policy_ids" {
    null = true
    type = sql("integer[]")
  }
  column "apply_immediately" {
    null = false
    type = boolean
  }
  column "transition_condition_reset_delay" {
    null = true
    type = integer
  }
  column "engineering_mode_enable_ota" {
    null = true
    type = boolean
  }
  primary_key {
    columns = [column.policy_id]
  }
  foreign_key "policy_data_policy_id_fkey" {
    columns     = [column.policy_id]
    ref_columns = [table.policy.column.policy_id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }
}
table "policy_data_source" {
  schema = schema.vdata
  column "policy_id" {
    null = false
    type = character_varying(36)
  }
  column "name" {
    null = false
    type = character_varying(128)
  }
  column "subpolicy_ids" {
    null = false
    type = sql("character varying(36)[]")
  }
  primary_key {
    columns = [column.policy_id, column.name]
  }
  foreign_key "policy_data_source_policy_id_fkey" {
    columns     = [column.policy_id]
    ref_columns = [table.policy.column.policy_id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }
}
table "policy_deployment" {
  schema = schema.vdata
  column "deployment_id" {
    null = false
    type = character_varying(36)
  }
  column "submission_id" {
    null = true
    type = character_varying(36)
  }
  column "policy_id" {
    null = false
    type = character_varying(36)
  }
  column "deploy_time" {
    null = true
    type = timestamptz
  }
  column "deployed_by" {
    null = true
    type = character_varying(32)
  }
  column "state" {
    null = false
    type = character_varying(36)
  }
  column "description" {
    null = true
    type = character_varying(256)
  }
  column "vehicle_filter_id" {
    null = false
    type = character_varying(36)
  }
  primary_key {
    columns = [column.deployment_id]
  }
  foreign_key "policy_deployment_deployed_by_fkey" {
    columns     = [column.deployed_by]
    ref_columns = [table.user.column.user_id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  foreign_key "policy_deployment_policy_id_fkey" {
    columns     = [column.policy_id]
    ref_columns = [table.policy.column.policy_id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }
  foreign_key "policy_deployment_submission_id_fkey" {
    columns     = [column.submission_id]
    ref_columns = [table.policy_submission.column.submission_id]
    on_update   = CASCADE
    on_delete   = CASCADE
  }
  foreign_key "policy_deployment_vehicle_filter_id_fkey" {
    columns     = [column.vehicle_filter_id]
    ref_columns = [table.fleet.column.name]
    on_update   = CASCADE
    on_delete   = CASCADE
  }
}
table "policy_original_data" {
  schema = schema.vdata
  column "policy_id" {
    null = false
    type = character_varying(36)
  }
  column "trigger_condition_ids_map" {
    null = true
    type = sql("integer[]")
  }
  column "trigger_policy_ids_map" {
    null = true
    type = sql("integer[]")
  }
  column "original_data" {
    null = false
    type = json
  }
  primary_key {
    columns = [column.policy_id]
  }
  foreign_key "policy_original_data_policy_id_fkey" {
    columns     = [column.policy_id]
    ref_columns = [table.policy.column.policy_id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }
}
table "policy_submission" {
  schema = schema.vdata
  column "submission_id" {
    null = false
    type = character_varying(36)
  }
  column "apply_policy_ids" {
    null = true
    type = sql("character varying(36)[]")
  }
  column "unapply_policy_ids" {
    null = true
    type = sql("character varying(36)[]")
  }
  column "submit_time" {
    null = false
    type = timestamptz
  }
  column "submitted_by" {
    null = false
    type = character_varying(32)
  }
  column "schedule_time" {
    null = true
    type = timestamptz
  }
  column "state" {
    null = false
    type = character_varying(36)
  }
  column "encrypted" {
    null = false
    type = boolean
  }
  column "error_msg" {
    null = true
    type = character_varying(512)
  }
  column "vehicle_filter_id" {
    null = false
    type = character_varying(36)
  }
  primary_key {
    columns = [column.submission_id]
  }
  foreign_key "policy_submission_submitted_by_fkey" {
    columns     = [column.submitted_by]
    ref_columns = [table.user.column.user_id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  foreign_key "policy_submission_vehicle_filter_id_fkey" {
    columns     = [column.vehicle_filter_id]
    ref_columns = [table.fleet.column.name]
    on_update   = CASCADE
    on_delete   = CASCADE
  }
}
table "policy_transaction" {
  schema = schema.vdata
  column "transaction_id" {
    null = false
    type = character_varying(36)
  }
  column "policy_ids" {
    null = true
    type = sql("character varying(36)[]")
  }
  primary_key {
    columns = [column.transaction_id]
  }
}
table "recipe" {
  schema = schema.vdata
  column "policy_id" {
    null = false
    type = character_varying(36)
  }
  column "apply_immediately" {
    null = false
    type = boolean
  }
  column "status_updates_endpoint" {
    null = true
    type = text
  }
  column "variables" {
    null = true
    type = sql("text[]")
  }
  column "constants" {
    null = true
    type = sql("text[]")
  }
  column "workflows" {
    null = true
    type = sql("text[]")
  }
  column "workflow_descriptions" {
    null = true
    type = sql("text[]")
  }
  column "trigger_conditions" {
    null = true
    type = sql("text[]")
  }
  column "tasks" {
    null = true
    type = sql("text[]")
  }
  column "actions" {
    null = true
    type = sql("text[]")
  }
  column "action_descriptions" {
    null = true
    type = sql("text[]")
  }
  column "use_case" {
    null    = false
    type    = character_varying(32)
    default = "RECIPE"
  }
  primary_key {
    columns = [column.policy_id]
  }
  foreign_key "recipe_policy_id_fkey" {
    columns     = [column.policy_id]
    ref_columns = [table.policy.column.policy_id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }
}
table "recipe_execution_event" {
  schema = schema.vdata
  column "vehicle_id" {
    null = false
    type = character_varying(36)
  }
  column "recipe_name" {
    null = false
    type = character_varying(256)
  }
  column "recipe_version" {
    null = false
    type = integer
  }
  column "event_time" {
    null = false
    type = timestamptz
  }
  column "workflow_name" {
    null = true
    type = text
  }
  column "workflow_state" {
    null = true
    type = text
  }
  column "workflow_start" {
    null = true
    type = boolean
  }
  column "task_name" {
    null = true
    type = text
  }
  column "action_name" {
    null = true
    type = text
  }
  column "action_success" {
    null = true
    type = boolean
  }
  foreign_key "recipe_execution_event_vehicle_id_fkey" {
    columns     = [column.vehicle_id]
    ref_columns = [table.vin_vehicle_id.column.vehicle_id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }
}
table "recipe_update_event" {
  schema = schema.vdata
  column "vehicle_id" {
    null = false
    type = character_varying(36)
  }
  column "event_time" {
    null = false
    type = timestamptz
  }
  column "prev_recipe_name" {
    null = true
    type = text
  }
  column "prev_recipe_version" {
    null = true
    type = integer
  }
  column "current_recipe_name" {
    null = true
    type = text
  }
  column "current_recipe_version" {
    null = true
    type = integer
  }
  foreign_key "recipe_update_event_vehicle_id_fkey" {
    columns     = [column.vehicle_id]
    ref_columns = [table.vin_vehicle_id.column.vehicle_id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }
}
table "recorded_event" {
  schema = schema.vdata
  column "event_id" {
    null = false
    type = character_varying(36)
  }
  column "policy_id" {
    null = false
    type = character_varying(36)
  }
  column "vehicle_id" {
    null = false
    type = character_varying(36)
  }
  column "trigger_policy_id" {
    null = false
    type = integer
  }
  column "start_time" {
    null = false
    type = timestamptz
  }
  column "stop_time" {
    null = true
    type = timestamptz
  }
  column "duration_before_start" {
    null = false
    type = integer
  }
  column "frame_file_paths" {
    null = true
    type = sql("text[]")
  }
  column "state" {
    null = false
    type = character_varying(20)
  }
  column "comment" {
    null = true
    type = text
  }
  column "upload_time" {
    null    = true
    type    = timestamptz
    default = sql("CURRENT_TIMESTAMP")
  }
  column "modification_time" {
    null = true
    type = timestamptz
  }
  primary_key {
    columns = [column.event_id]
  }
  index "recorded_event_vehicle_id_policy_id_trigger_policy_id_start_idx" {
    unique  = true
    columns = [column.vehicle_id, column.policy_id, column.trigger_policy_id, column.start_time]
  }
}
table "recorded_frame" {
  schema = schema.vdata
  column "vehicle_id" {
    null = false
    type = character_varying(36)
  }
  column "frame_id" {
    null = true
    type = character_varying(36)
  }
  column "file_path" {
    null = false
    type = text
  }
  column "camera" {
    null = false
    type = character_varying(16)
  }
  column "event_time" {
    null = false
    type = timestamptz
  }
  column "latitude" {
    null = false
    type = double_precision
  }
  column "longtitude" {
    null = false
    type = double_precision
  }
  column "frame_size" {
    null = true
    type = integer
  }
  column "deep_learning_model" {
    null = false
    type = character_varying(16)
  }
  column "uncertainty" {
    null = false
    type = double_precision
  }
  column "upload_time" {
    null    = true
    type    = timestamptz
    default = sql("CURRENT_TIMESTAMP")
  }
  primary_key {
    columns = [column.vehicle_id, column.file_path, column.event_time]
  }
}
table "saved_action" {
  schema = schema.vdata
  column "name" {
    null = false
    type = text
  }
  column "display_name" {
    null = false
    type = text
  }
  column "model_name" {
    null = false
    type = character_varying(16)
  }
  column "can_db_version" {
    null = false
    type = character_varying(32)
  }
  column "eth_db_version" {
    null = false
    type = character_varying(32)
  }
  column "description" {
    null = true
    type = text
  }
  column "labels" {
    null = true
    type = sql("text[]")
  }
  column "created_by" {
    null = false
    type = character_varying(32)
  }
  column "creation_time" {
    null = false
    type = timestamptz
  }
  column "last_use_time" {
    null = false
    type = timestamptz
  }
  column "action_type" {
    null = false
    type = character_varying(32)
  }
  column "usage_count" {
    null = false
    type = integer
  }
  column "recipe_schema_version" {
    null = false
    type = text
  }
  column "data" {
    null = false
    type = text
  }
  column "disabled" {
    null    = false
    type    = boolean
    default = false
  }
  column "disabled_by" {
    null = true
    type = character_varying(32)
  }
  column "disabled_reason" {
    null = true
    type = text
  }
  primary_key {
    columns = [column.name]
  }
  foreign_key "saved_action_created_by_fkey" {
    columns     = [column.created_by]
    ref_columns = [table.user.column.user_id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  foreign_key "saved_action_disabled_by_fkey" {
    columns     = [column.disabled_by]
    ref_columns = [table.user.column.user_id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  index "saved_action_data_key" {
    unique  = true
    columns = [column.data]
  }
}
table "saved_trigger_condition" {
  schema = schema.vdata
  column "name" {
    null = false
    type = text
  }
  column "display_name" {
    null = false
    type = text
  }
  column "model_name" {
    null = false
    type = character_varying(16)
  }
  column "can_db_version" {
    null = false
    type = character_varying(32)
  }
  column "eth_db_version" {
    null = false
    type = character_varying(32)
  }
  column "description" {
    null = true
    type = text
  }
  column "labels" {
    null = true
    type = sql("text[]")
  }
  column "created_by" {
    null = false
    type = character_varying(32)
  }
  column "creation_time" {
    null = false
    type = timestamptz
  }
  column "last_use_time" {
    null = false
    type = timestamptz
  }
  column "condition_type" {
    null = false
    type = character_varying(32)
  }
  column "usage_count" {
    null = false
    type = integer
  }
  column "recipe_schema_version" {
    null = false
    type = text
  }
  column "data" {
    null = false
    type = text
  }
  column "disabled" {
    null    = false
    type    = boolean
    default = false
  }
  column "disabled_by" {
    null = true
    type = character_varying(32)
  }
  column "disabled_reason" {
    null = true
    type = text
  }
  primary_key {
    columns = [column.name]
  }
  foreign_key "saved_trigger_condition_created_by_fkey" {
    columns     = [column.created_by]
    ref_columns = [table.user.column.user_id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  foreign_key "saved_trigger_condition_disabled_by_fkey" {
    columns     = [column.disabled_by]
    ref_columns = [table.user.column.user_id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  index "saved_trigger_condition_data_key" {
    unique  = true
    columns = [column.data]
  }
}
table "security_incident_event_id" {
  schema = schema.vdata
  column "incident_id" {
    null = false
    type = character_varying(36)
  }
  column "vehicle_id" {
    null = false
    type = character_varying(36)
  }
  column "event_id" {
    null = false
    type = character_varying(36)
  }
  column "event_type" {
    null = false
    type = character_varying(10)
  }
  primary_key {
    columns = [column.incident_id, column.vehicle_id, column.event_id]
  }
  foreign_key "security_incident_event_id_incident_id_fkey" {
    columns     = [column.incident_id]
    ref_columns = [table.vehicle_security_incident.column.incident_id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  foreign_key "security_incident_event_id_vehicle_id_fkey" {
    columns     = [column.vehicle_id]
    ref_columns = [table.vin_vehicle_id.column.vehicle_id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }
}
table "service_group" {
  schema = schema.vdata
  column "name" {
    null = false
    type = character_varying(32)
  }
  column "apn_name" {
    null = true
    type = character_varying(32)
  }
  column "model_name" {
    null = false
    type = character_varying(16)
  }
  column "tx_field_name" {
    null = false
    type = character_varying(64)
  }
  column "rx_field_name" {
    null = false
    type = character_varying(64)
  }
  column "created_by" {
    null = false
    type = character_varying(32)
  }
  column "creation_time" {
    null = false
    type = timestamptz
  }
  column "modified_by" {
    null = true
    type = character_varying(32)
  }
  column "modification_time" {
    null = true
    type = timestamptz
  }
  column "can_apply_data_cap_policy" {
    null    = true
    type    = boolean
    default = false
  }
  primary_key {
    columns = [column.name, column.model_name]
  }
  foreign_key "service_group_apn_name_model_name_fkey" {
    columns     = [column.apn_name, column.model_name]
    ref_columns = [table.apn.column.name, table.apn.column.model_name]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  foreign_key "service_group_created_by_fkey" {
    columns     = [column.created_by]
    ref_columns = [table.user.column.user_id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  foreign_key "service_group_modified_by_fkey" {
    columns     = [column.modified_by]
    ref_columns = [table.user.column.user_id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
}
table "signals_capture" {
  schema = schema.vdata
  column "policy_id" {
    null = false
    type = character_varying(36)
  }
  column "trigger_policy_id" {
    null = false
    type = integer
  }
  column "names" {
    null = false
    type = sql("text[]")
  }
  column "sample_interval" {
    null = false
    type = integer
  }
  column "duration_before_start" {
    null = true
    type = integer
  }
  primary_key {
    columns = [column.policy_id, column.trigger_policy_id]
  }
  foreign_key "signals_capture_policy_id_fkey" {
    columns     = [column.policy_id]
    ref_columns = [table.policy.column.policy_id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }
  foreign_key "signals_capture_trigger_policy_id_fkey" {
    columns     = [column.trigger_policy_id]
    ref_columns = [table.trigger_policy.column.trigger_policy_id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
}
table "software_version" {
  schema = schema.vdata
  column "vehicle_id" {
    null = false
    type = character_varying(36)
  }
  column "model" {
    null = false
    type = character_varying(16)
  }
  column "app" {
    null = false
    type = character_varying(32)
  }
  column "version" {
    null = false
    type = character_varying(16)
  }
  column "modification_time" {
    null = true
    type = timestamptz
  }
  primary_key {
    columns = [column.vehicle_id, column.model, column.app]
  }
  foreign_key "software_version_vehicle_id_fkey" {
    columns     = [column.vehicle_id]
    ref_columns = [table.vin_vehicle_id.column.vehicle_id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }
}
table "source_subpolicy" {
  schema = schema.vdata
  column "policy_id" {
    null = false
    type = character_varying(36)
  }
  column "data_id" {
    null = false
    type = character_varying(32)
  }
  column "subpolicy_ids" {
    null = true
    type = sql("character varying(36)[]")
  }
  primary_key {
    columns = [column.policy_id, column.data_id]
  }
  foreign_key "source_subpolicy_policy_id_fkey" {
    columns     = [column.policy_id]
    ref_columns = [table.policy.column.policy_id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }
}
table "src_ip_ecu" {
  schema = schema.vdata
  column "model_name" {
    null = false
    type = character_varying(16)
  }
  column "version" {
    null = false
    type = character_varying(32)
  }
  column "src_ip" {
    null = false
    type = character_varying(32)
  }
  column "ecu_name" {
    null = false
    type = character_varying(16)
  }
  primary_key {
    columns = [column.model_name, column.version, column.src_ip]
  }
}
table "storage_policy" {
  schema = schema.vdata
  column "policy_id" {
    null = false
    type = character_varying(36)
  }
  column "max_num_files" {
    null = true
    type = integer
  }
  column "max_file_size" {
    null = true
    type = integer
  }
  column "max_buffer_size" {
    null = true
    type = integer
  }
  column "raw_json" {
    null = false
    type = json
  }
  primary_key {
    columns = [column.policy_id]
  }
  foreign_key "storage_policy_policy_id_fkey" {
    columns     = [column.policy_id]
    ref_columns = [table.policy.column.policy_id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }
}
table "system_share_directory" {
  schema = schema.vdata
  column "directory_id" {
    null = false
    type = character_varying(36)
  }
  column "name" {
    null = false
    type = character_varying(32)
  }
  column "path" {
    null = false
    type = character_varying(256)
  }
  column "user_owner" {
    null = false
    type = character_varying(32)
  }
  column "group_owner" {
    null = false
    type = character_varying(32)
  }
  primary_key {
    columns = [column.directory_id]
  }
  index "system_share_directory_name_path_user_owner_group_owner_key" {
    unique  = true
    columns = [column.name, column.path, column.user_owner, column.group_owner]
  }
}
table "system_share_export" {
  schema = schema.vdata
  column "export_id" {
    null = false
    type = character_varying(36)
  }
  column "ip_addr" {
    null = false
    type = character_varying(16)
  }
  column "options" {
    null = false
    type = text
  }
  primary_key {
    columns = [column.export_id]
  }
  index "system_share_export_ip_addr_options_key" {
    unique  = true
    columns = [column.ip_addr, column.options]
  }
}
table "translation_rule" {
  schema = schema.vdata
  column "model_name" {
    null = false
    type = character_varying(16)
  }
  column "can_db_version" {
    null = false
    type = character_varying(32)
  }
  column "eth_db_version" {
    null = false
    type = character_varying(32)
  }
  column "engine_type_id" {
    null = false
    type = integer
  }
  column "translation_name" {
    null = false
    type = character_varying(128)
  }
  column "raw_name" {
    null = false
    type = character_varying(128)
  }
  column "soa_name" {
    null = true
    type = character_varying(128)
  }
  column "actuator" {
    null = false
    type = boolean
  }
  column "type" {
    null = true
    type = character_varying(16)
  }
  column "unit" {
    null = true
    type = character_varying(16)
  }
  column "created_by" {
    null = false
    type = character_varying(32)
  }
  column "creation_time" {
    null = false
    type = timestamptz
  }
  primary_key {
    columns = [column.model_name, column.can_db_version, column.eth_db_version, column.engine_type_id, column.translation_name]
  }
  foreign_key "translation_rule_created_by_fkey" {
    columns     = [column.created_by]
    ref_columns = [table.user.column.user_id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  index "translation_rule_model_name_can_db_version_eth_db_version__key1" {
    unique  = true
    columns = [column.model_name, column.can_db_version, column.eth_db_version, column.engine_type_id, column.soa_name]
  }
  index "translation_rule_model_name_can_db_version_eth_db_version_e_key" {
    unique  = true
    columns = [column.model_name, column.can_db_version, column.eth_db_version, column.engine_type_id, column.raw_name]
  }
}
table "transmission_policy" {
  schema = schema.vdata
  column "policy_id" {
    null = false
    type = character_varying(36)
  }
  column "compress" {
    null = true
    type = boolean
  }
  column "transmission_interval" {
    null = false
    type = integer
  }
  column "retry_interval" {
    null = true
    type = integer
  }
  column "max_retries" {
    null = true
    type = integer
  }
  column "path" {
    null = false
    type = text
  }
  column "raw_json" {
    null = false
    type = json
  }
  primary_key {
    columns = [column.policy_id]
  }
  foreign_key "transmission_policy_policy_id_fkey" {
    columns     = [column.policy_id]
    ref_columns = [table.policy.column.policy_id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }
}
table "trigger_condition" {
  schema = schema.vdata
  column "trigger_condition_id" {
    null = false
    type = integer
    identity {
      generated = ALWAYS
    }
  }
  column "type" {
    null = false
    type = integer
  }
  column "name" {
    null = true
    type = text
  }
  column "operator" {
    null = true
    type = character_varying(3)
  }
  column "physical_val" {
    null = false
    type = boolean
  }
  column "value" {
    null = true
    type = text
  }
  column "capture_last_missed_schedule" {
    null = true
    type = boolean
  }
  column "delay" {
    null = true
    type = integer
  }
  column "condition" {
    null = false
    type = text
  }
  column "raw_json" {
    null = false
    type = json
  }
  primary_key {
    columns = [column.trigger_condition_id]
  }
}
table "trigger_policy" {
  schema = schema.vdata
  column "trigger_policy_id" {
    null = false
    type = integer
    identity {
      generated = ALWAYS
    }
  }
  column "name" {
    null = true
    type = character_varying(256)
  }
  column "start_conditions" {
    null = false
    type = sql("integer[]")
  }
  column "stop_conditions" {
    null = false
    type = sql("integer[]")
  }
  column "expire_conditions_events" {
    null = true
    type = sql("integer[]")
  }
  column "expire_conditions_occurrence" {
    null = true
    type = integer
  }
  column "max_starts" {
    null = true
    type = integer
  }
  column "keep_trigger_state" {
    null = true
    type = boolean
  }
  column "raw_json" {
    null = false
    type = json
  }
  primary_key {
    columns = [column.trigger_policy_id]
  }
}
table "trigger_policy_data_record" {
  schema = schema.vdata
  column "vehicle_id" {
    null = false
    type = character_varying(36)
  }
  column "policy_id" {
    null = false
    type = character_varying(36)
  }
  column "trigger_policy_ids" {
    null = true
    type = sql("integer[]")
  }
  column "event_time" {
    null = true
    type = timestamptz
  }
  column "data_type" {
    null = false
    type = character_varying(24)
  }
  column "data" {
    null = false
    type = bytea
  }
  column "creation_time" {
    null    = true
    type    = timestamptz
    default = sql("CURRENT_TIMESTAMP")
  }
  index "trigger_policy_data_record_vehicle_id_policy_id_trigger_pol_idx" {
    columns = [column.vehicle_id, column.policy_id, column.trigger_policy_ids, column.event_time]
  }
}
table "trigger_policy_metadata" {
  schema = schema.vdata
  column "vehicle_id" {
    null = false
    type = character_varying(36)
  }
  column "policy_id" {
    null = false
    type = character_varying(36)
  }
  column "trigger_policy_id" {
    null = false
    type = integer
  }
  column "start_time" {
    null = false
    type = timestamptz
  }
  column "end_time" {
    null = true
    type = timestamptz
  }
  column "state" {
    null = false
    type = character_varying(8)
  }
  column "creation_time" {
    null    = true
    type    = timestamptz
    default = sql("CURRENT_TIMESTAMP")
  }
  primary_key {
    columns = [column.vehicle_id, column.policy_id, column.trigger_policy_id, column.start_time]
  }
  index "trigger_policy_metadata_creation_time_idx" {
    columns = [column.creation_time]
  }
}
table "use_case" {
  schema = schema.vdata
  column "use_case_name" {
    null = false
    type = character_varying(32)
  }
  column "kafka_topic_name_complete_data" {
    null = false
    type = character_varying(64)
  }
  column "kafka_topic_name_incomplete_data" {
    null = false
    type = character_varying(64)
  }
  column "max_time_to_wait_for_stop_record" {
    null = false
    type = integer
  }
  column "created_by" {
    null = false
    type = character_varying(256)
  }
  column "creation_time" {
    null = false
    type = timestamptz
  }
  column "modification_time" {
    null = false
    type = timestamptz
  }
  primary_key {
    columns = [column.use_case_name]
  }
  foreign_key "use_case_created_by_fkey" {
    columns     = [column.created_by]
    ref_columns = [table.user.column.user_id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
}
table "user" {
  schema = schema.vdata
  column "user_id" {
    null = false
    type = character_varying(32)
  }
  column "first_name" {
    null = false
    type = character_varying(64)
  }
  column "last_name" {
    null = false
    type = character_varying(32)
  }
  column "email" {
    null = true
    type = character_varying(120)
  }
  column "password" {
    null = true
    type = character_varying(80)
  }
  column "disabled" {
    null = false
    type = boolean
  }
  column "creation_time" {
    null = false
    type = timestamptz
  }
  column "modification_time" {
    null = false
    type = timestamptz
  }
  primary_key {
    columns = [column.user_id]
  }
}
table "vam_http_action_request" {
  schema = schema.vdata
  column "receive_time" {
    null = false
    type = timestamptz
  }
  column "headers" {
    null = true
    type = text
  }
  column "body" {
    null = true
    type = text
  }
}
table "vcc_stats_capture" {
  schema = schema.vdata
  column "policy_id" {
    null = false
    type = character_varying(36)
  }
  column "trigger_policy_id" {
    null = false
    type = integer
  }
  column "stats" {
    null = false
    type = text
  }
  column "sample_interval" {
    null = false
    type = integer
  }
  primary_key {
    columns = [column.policy_id, column.trigger_policy_id]
  }
  foreign_key "vcc_stats_capture_policy_id_fkey" {
    columns     = [column.policy_id]
    ref_columns = [table.policy.column.policy_id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }
  foreign_key "vcc_stats_capture_trigger_policy_id_fkey" {
    columns     = [column.trigger_policy_id]
    ref_columns = [table.trigger_policy.column.trigger_policy_id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
}
table "vehicle" {
  schema = schema.vdata
  column "vehicle_id" {
    null = false
    type = character_varying(36)
  }
  column "unit" {
    null = false
    type = character_varying(10)
  }
  column "brand_name" {
    null = false
    type = character_varying(16)
  }
  column "model_name" {
    null = true
    type = character_varying(16)
  }
  column "can_db_version" {
    null = true
    type = character_varying(32)
  }
  column "eth_db_version" {
    null = true
    type = character_varying(32)
  }
  column "engine_type" {
    null = true
    type = integer
  }
  column "online" {
    null = true
    type = boolean
  }
  column "protocol_ids" {
    null = true
    type = sql("character varying(40)[]")
  }
  column "disabled" {
    null = false
    type = boolean
  }
  column "creation_time" {
    null = false
    type = timestamptz
  }
  column "modification_time" {
    null = false
    type = timestamptz
  }
  primary_key {
    columns = [column.vehicle_id]
  }
  foreign_key "vehicle_vehicle_id_fkey" {
    columns     = [column.vehicle_id]
    ref_columns = [table.vin_vehicle_id.column.vehicle_id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }
  index "vehicle_can_db_version_idx" {
    columns = [column.can_db_version]
  }
  index "vehicle_creation_time_idx" {
    columns = [column.creation_time]
  }
  index "vehicle_eth_db_version_idx" {
    columns = [column.eth_db_version]
  }
  index "vehicle_modification_time_idx" {
    columns = [column.modification_time]
  }
}
table "vehicle_attribute" {
  schema = schema.vdata
  column "vehicle_id" {
    null = false
    type = character_varying(36)
  }
  column "name" {
    null = false
    type = character_varying(32)
  }
  column "value" {
    null = false
    type = character_varying(64)
  }
  primary_key {
    columns = [column.vehicle_id, column.name]
  }
  foreign_key "vehicle_attribute_vehicle_id_fkey" {
    columns     = [column.vehicle_id]
    ref_columns = [table.vin_vehicle_id.column.vehicle_id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }
  index "vehicle_attribute_name_idx" {
    columns = [column.name]
  }
  index "vehicle_attribute_value_idx" {
    columns = [column.value]
  }
}
table "vehicle_attributes_capture" {
  schema = schema.vdata
  column "policy_id" {
    null = false
    type = character_varying(36)
  }
  column "trigger_policy_id" {
    null = false
    type = integer
  }
  column "value" {
    null = false
    type = boolean
  }
  primary_key {
    columns = [column.policy_id, column.trigger_policy_id]
  }
  foreign_key "vehicle_attributes_capture_policy_id_fkey" {
    columns     = [column.policy_id]
    ref_columns = [table.policy.column.policy_id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }
  foreign_key "vehicle_attributes_capture_trigger_policy_id_fkey" {
    columns     = [column.trigger_policy_id]
    ref_columns = [table.trigger_policy.column.trigger_policy_id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
}
table "vehicle_canids_event" {
  schema = schema.vdata
  column "event_id" {
    null = false
    type = character_varying(36)
  }
  column "vehicle_id" {
    null = false
    type = character_varying(36)
  }
  column "attack_id" {
    null = false
    type = character_varying(36)
  }
  column "bus_id" {
    null = false
    type = character_varying(10)
  }
  column "ca_data" {
    null = true
    type = text
  }
  column "can_id" {
    null = true
    type = integer
  }
  column "info" {
    null = true
    type = text
  }
  column "is_can_fd" {
    null = true
    type = integer
  }
  column "rule_id" {
    null = true
    type = integer
  }
  column "signal_id" {
    null = true
    type = integer
  }
  column "can_dlc" {
    null = true
    type = character_varying(10)
  }
  column "event_time" {
    null = false
    type = timestamptz
  }
  column "creation_time" {
    null = false
    type = timestamptz
  }
  primary_key {
    columns = [column.event_id]
  }
  foreign_key "vehicle_canids_event_vehicle_id_fkey" {
    columns     = [column.vehicle_id]
    ref_columns = [table.vin_vehicle_id.column.vehicle_id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }
  index "vehicle_canids_event_vehicle_id_attack_id_event_time_idx" {
    columns = [column.vehicle_id, column.attack_id, column.event_time]
  }
}
table "vehicle_canids_stats" {
  schema = schema.vdata
  column "vehicle_id" {
    null = false
    type = character_varying(36)
  }
  column "attack_ids" {
    null = true
    type = sql("character varying(36)[]")
  }
  column "eids_eth_pkts" {
    null = true
    type = bigint
  }
  column "eids_eth_bytes" {
    null = true
    type = bigint
  }
  column "eids_dup_pkts" {
    null = true
    type = bigint
  }
  column "eids_dup_bytes" {
    null = true
    type = bigint
  }
  column "eids_nonip_pkts" {
    null = true
    type = bigint
  }
  column "eids_nonip_bytes" {
    null = true
    type = bigint
  }
  column "eids_ip_pkts" {
    null = true
    type = bigint
  }
  column "eids_ip_bytes" {
    null = true
    type = bigint
  }
  column "eids_tcp_pkts" {
    null = true
    type = bigint
  }
  column "eids_tcp_bytes" {
    null = true
    type = bigint
  }
  column "eids_udp_pkts" {
    null = true
    type = bigint
  }
  column "eids_udp_bytes" {
    null = true
    type = bigint
  }
  column "eids_icmp_pkts" {
    null = true
    type = bigint
  }
  column "eids_icmp_bytes" {
    null = true
    type = bigint
  }
  column "vsoc_api_update_version" {
    null = true
    type = integer
  }
  column "vsoc_api_get_config" {
    null = true
    type = integer
  }
  column "vsoc_api_get_status" {
    null = true
    type = integer
  }
  column "vsoc_api_update_stats" {
    null = true
    type = integer
  }
  column "vsoc_api_get_stats" {
    null = true
    type = integer
  }
  column "vsoc_api_get_ruleset" {
    null = true
    type = integer
  }
  column "vsoc_api_get_alert_log_list" {
    null = true
    type = integer
  }
  column "vsoc_api_get_alert_log" {
    null = true
    type = integer
  }
  column "vsoc_api_update_alert" {
    null = true
    type = integer
  }
  column "vsoc_api_get_pcap_list" {
    null = true
    type = integer
  }
  column "vsoc_api_get_pcap_log" {
    null = true
    type = integer
  }
  column "event_time" {
    null = false
    type = timestamptz
  }
  column "creation_time" {
    null = false
    type = timestamptz
  }
  foreign_key "vehicle_canids_stats_vehicle_id_fkey" {
    columns     = [column.vehicle_id]
    ref_columns = [table.vin_vehicle_id.column.vehicle_id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }
  index "vehicle_canids_stats_vehicle_id_event_time_idx" {
    columns = [column.vehicle_id, column.event_time]
  }
}
table "vehicle_canids_status" {
  schema = schema.vdata
  column "vehicle_id" {
    null = false
    type = character_varying(36)
  }
  column "canids_version" {
    null = true
    type = bigint
  }
  column "analyzer_version" {
    null = true
    type = bigint
  }
  column "ruleset_version" {
    null = true
    type = integer
  }
  column "api_version" {
    null = true
    type = bigint
  }
  column "config_version" {
    null = true
    type = bigint
  }
  column "analyzer_running_state" {
    null = true
    type = integer
  }
  column "individual_algorithm" {
    null = true
    type = integer
  }
  column "event_storming_time" {
    null = true
    type = integer
  }
  column "event_storming_count" {
    null = true
    type = integer
  }
  column "vender_id" {
    null = true
    type = character_varying(36)
  }
  column "vin" {
    null = true
    type = character_varying(64)
  }
  column "region" {
    null = true
    type = bigint
  }
  column "time_mode" {
    null = true
    type = integer
  }
  column "event_time" {
    null = false
    type = timestamptz
  }
  column "creation_time" {
    null = false
    type = timestamptz
  }
  foreign_key "vehicle_canids_status_vehicle_id_fkey" {
    columns     = [column.vehicle_id]
    ref_columns = [table.vin_vehicle_id.column.vehicle_id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }
}
table "vehicle_cloud_ids_event" {
  schema = schema.vdata
  column "event_id" {
    null = false
    type = character_varying(36)
  }
  column "vehicle_id" {
    null = false
    type = character_varying(36)
  }
  column "attack_id" {
    null = false
    type = character_varying(36)
  }
  column "description" {
    null = true
    type = text
  }
  column "event_type" {
    null = false
    type = character_varying(20)
  }
  column "dns_entry_id" {
    null = true
    type = character_varying(36)
  }
  column "netflow_id" {
    null = true
    type = character_varying(36)
  }
  column "event_time" {
    null = false
    type = timestamptz
  }
  column "creation_time" {
    null = false
    type = timestamptz
  }
  primary_key {
    columns = [column.event_id]
  }
  foreign_key "vehicle_cloud_ids_event_dns_entry_id_fkey" {
    columns     = [column.dns_entry_id]
    ref_columns = [table.vehicle_dns_entry.column.entry_id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  foreign_key "vehicle_cloud_ids_event_netflow_id_fkey" {
    columns     = [column.netflow_id]
    ref_columns = [table.vehicle_network_flow_entry.column.netflow_id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }
  foreign_key "vehicle_cloud_ids_event_vehicle_id_fkey" {
    columns     = [column.vehicle_id]
    ref_columns = [table.vin_vehicle_id.column.vehicle_id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }
  index "vehicle_cloud_ids_event_vehicle_id_attack_id_event_time_idx" {
    columns = [column.vehicle_id, column.attack_id, column.event_time]
  }
}
table "vehicle_data_cap_action" {
  schema = schema.vdata
  column "vehicle_id" {
    null = false
    type = character_varying(36)
  }
  column "action_id" {
    null = false
    type = character_varying(36)
  }
  column "creation_time" {
    null = false
    type = timestamptz
  }
  primary_key {
    columns = [column.vehicle_id, column.action_id]
  }
  foreign_key "vehicle_data_cap_action_action_id_fkey" {
    columns     = [column.action_id]
    ref_columns = [table.data_cap_action.column.action_id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  foreign_key "vehicle_data_cap_action_vehicle_id_fkey" {
    columns     = [column.vehicle_id]
    ref_columns = [table.vin_vehicle_id.column.vehicle_id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }
}
table "vehicle_data_cap_status" {
  schema = schema.vdata
  column "vehicle_id" {
    null = false
    type = character_varying(36)
  }
  column "deployment_id" {
    null = false
    type = character_varying(36)
  }
  column "state" {
    null = false
    type = character_varying(10)
  }
  column "creation_time" {
    null = false
    type = timestamptz
  }
  primary_key {
    columns = [column.vehicle_id, column.deployment_id, column.state]
  }
  foreign_key "vehicle_data_cap_status_deployment_id_fkey" {
    columns     = [column.deployment_id]
    ref_columns = [table.data_cap_deployment.column.deployment_id]
    on_update   = CASCADE
    on_delete   = CASCADE
  }
  foreign_key "vehicle_data_cap_status_vehicle_id_fkey" {
    columns     = [column.vehicle_id]
    ref_columns = [table.vin_vehicle_id.column.vehicle_id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }
  index "vehicle_data_cap_status_deployment_id_state_idx" {
    columns = [column.deployment_id, column.state]
  }
  index "vehicle_data_cap_status_vehicle_id_creation_time_state_idx" {
    columns = [column.vehicle_id, column.creation_time, column.state]
  }
}
table "vehicle_dns_entry" {
  schema = schema.vdata
  column "entry_id" {
    null = false
    type = character_varying(36)
  }
  column "request_id" {
    null = true
    type = character_varying(36)
  }
  column "vehicle_id" {
    null = false
    type = character_varying(36)
  }
  column "incident_id" {
    null = true
    type = character_varying(36)
  }
  column "client_id" {
    null = true
    type = character_varying(36)
  }
  column "domain_name" {
    null = false
    type = character_varying(255)
  }
  column "resolved_time" {
    null = true
    type = timestamptz
  }
  column "resolved_ipv4" {
    null = true
    type = character_varying(16)
  }
  column "resolved_ipv6" {
    null = true
    type = character_varying(32)
  }
  column "event_time" {
    null = false
    type = timestamptz
  }
  column "creation_time" {
    null = false
    type = timestamptz
  }
  primary_key {
    columns = [column.entry_id]
  }
  foreign_key "vehicle_dns_entry_incident_id_fkey" {
    columns     = [column.incident_id]
    ref_columns = [table.vehicle_security_incident.column.incident_id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  foreign_key "vehicle_dns_entry_vehicle_id_fkey" {
    columns     = [column.vehicle_id]
    ref_columns = [table.vin_vehicle_id.column.vehicle_id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }
  index "vehicle_dns_entry_vehicle_id_request_id_domain_name_event_t_idx" {
    columns = [column.vehicle_id, column.request_id, column.domain_name, column.event_time]
  }
}
table "vehicle_eids_event" {
  schema = schema.vdata
  column "event_id" {
    null = false
    type = character_varying(36)
  }
  column "vehicle_id" {
    null = false
    type = character_varying(36)
  }
  column "attack_id" {
    null = false
    type = character_varying(36)
  }
  column "arp_hw_type" {
    null = true
    type = integer
  }
  column "arp_sip" {
    null = true
    type = integer
  }
  column "arp_size" {
    null = true
    type = integer
  }
  column "arp_smac" {
    null = true
    type = integer
  }
  column "mac_dmac" {
    null = true
    type = integer
  }
  column "mac_smac" {
    null = true
    type = integer
  }
  column "mac_vlan" {
    null = true
    type = integer
  }
  column "ipv4_dst_addr" {
    null = true
    type = character_varying(16)
  }
  column "ipv4_src_addr" {
    null = true
    type = character_varying(16)
  }
  column "ipv6_src_addr0" {
    null = true
    type = character_varying(32)
  }
  column "ipv6_src_addr1" {
    null = true
    type = character_varying(32)
  }
  column "ipv6_dst_addr0" {
    null = true
    type = character_varying(32)
  }
  column "ipv6_dst_addr1" {
    null = true
    type = character_varying(32)
  }
  column "tcp_dport" {
    null = true
    type = integer
  }
  column "tcp_sport" {
    null = true
    type = integer
  }
  column "tcp_vlan" {
    null = true
    type = integer
  }
  column "udp_dport" {
    null = true
    type = integer
  }
  column "udp_sport" {
    null = true
    type = integer
  }
  column "udp_vlan" {
    null = true
    type = integer
  }
  column "event_time" {
    null = false
    type = timestamptz
  }
  column "creation_time" {
    null = false
    type = timestamptz
  }
  column "attack_description" {
    null = true
    type = character_varying(200)
  }
  primary_key {
    columns = [column.event_id]
  }
  foreign_key "vehicle_eids_event_vehicle_id_fkey" {
    columns     = [column.vehicle_id]
    ref_columns = [table.vin_vehicle_id.column.vehicle_id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }
  index "vehicle_eids_event_vehicle_id_attack_id_event_time_idx" {
    columns = [column.vehicle_id, column.attack_id, column.event_time]
  }
}
table "vehicle_eids_stats" {
  schema = schema.vdata
  column "vehicle_id" {
    null = false
    type = character_varying(36)
  }
  column "attack_ids" {
    null = true
    type = sql("character varying(36)[]")
  }
  column "eids_eth_pkts" {
    null = true
    type = bigint
  }
  column "eids_eth_bytes" {
    null = true
    type = bigint
  }
  column "eids_dup_pkts" {
    null = true
    type = bigint
  }
  column "eids_dup_bytes" {
    null = true
    type = bigint
  }
  column "eids_nonip_pkts" {
    null = true
    type = bigint
  }
  column "eids_nonip_bytes" {
    null = true
    type = bigint
  }
  column "eids_ip_pkts" {
    null = true
    type = bigint
  }
  column "eids_ip_bytes" {
    null = true
    type = bigint
  }
  column "eids_tcp_pkts" {
    null = true
    type = bigint
  }
  column "eids_tcp_bytes" {
    null = true
    type = bigint
  }
  column "eids_udp_pkts" {
    null = true
    type = bigint
  }
  column "eids_udp_bytes" {
    null = true
    type = bigint
  }
  column "eids_icmp_pkts" {
    null = true
    type = bigint
  }
  column "eids_icmp_bytes" {
    null = true
    type = bigint
  }
  column "vsoc_api_update_version" {
    null = true
    type = integer
  }
  column "vsoc_api_get_config" {
    null = true
    type = integer
  }
  column "vsoc_api_get_status" {
    null = true
    type = integer
  }
  column "vsoc_api_update_stats" {
    null = true
    type = integer
  }
  column "vsoc_api_get_stats" {
    null = true
    type = integer
  }
  column "vsoc_api_get_ruleset" {
    null = true
    type = integer
  }
  column "vsoc_api_get_alert_log_list" {
    null = true
    type = integer
  }
  column "vsoc_api_get_alert_log" {
    null = true
    type = integer
  }
  column "vsoc_api_update_alert" {
    null = true
    type = integer
  }
  column "vsoc_api_get_pcap_list" {
    null = true
    type = integer
  }
  column "vsoc_api_api_pcap_log" {
    null = true
    type = integer
  }
  column "event_time" {
    null = false
    type = timestamptz
  }
  column "creation_time" {
    null = false
    type = timestamptz
  }
  foreign_key "vehicle_eids_stats_vehicle_id_fkey" {
    columns     = [column.vehicle_id]
    ref_columns = [table.vin_vehicle_id.column.vehicle_id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }
}
table "vehicle_eids_status" {
  schema = schema.vdata
  column "vehicle_id" {
    null = false
    type = character_varying(36)
  }
  column "eids_version" {
    null = true
    type = bigint
  }
  column "analyzer_version" {
    null = true
    type = bigint
  }
  column "ruleset_version" {
    null = true
    type = character_varying(50)
  }
  column "api_version" {
    null = true
    type = bigint
  }
  column "config_version" {
    null = true
    type = bigint
  }
  column "analyzer_running_state" {
    null = true
    type = integer
  }
  column "vender_id" {
    null = true
    type = character_varying(36)
  }
  column "vin" {
    null = true
    type = character_varying(64)
  }
  column "region" {
    null = true
    type = bigint
  }
  column "connectivity" {
    null = true
    type = bigint
  }
  column "ap_version" {
    null = true
    type = character_varying(36)
  }
  column "switch_version" {
    null = true
    type = character_varying(36)
  }
  column "eth_db_version" {
    null = true
    type = character_varying(36)
  }
  column "time_mode" {
    null = true
    type = integer
  }
  column "up_time" {
    null = true
    type = bigint
  }
  column "event_time" {
    null = false
    type = timestamptz
  }
  column "creation_time" {
    null = false
    type = timestamptz
  }
  foreign_key "vehicle_eids_status_vehicle_id_fkey" {
    columns     = [column.vehicle_id]
    ref_columns = [table.vin_vehicle_id.column.vehicle_id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }
}
table "vehicle_eth_stat" {
  schema = schema.vdata
  column "vehicle_id" {
    null = false
    type = character_varying(36)
  }
  column "switch_id" {
    null = false
    type = integer
  }
  column "zone_id" {
    null = false
    type = integer
  }
  column "port_id" {
    null = false
    type = integer
  }
  column "tx_bytes_counter" {
    null = false
    type = bigint
  }
  column "tx_drop_packet_counter" {
    null = false
    type = integer
  }
  column "tx_broadcast_packet_counter" {
    null = false
    type = integer
  }
  column "tx_q0_packet_counter" {
    null = false
    type = integer
  }
  column "tx_multicast_packet_counter" {
    null = false
    type = integer
  }
  column "tx_unicast_packet_counter" {
    null = false
    type = integer
  }
  column "tx_collision_counter" {
    null = false
    type = integer
  }
  column "tx_single_collision_counter" {
    null = false
    type = integer
  }
  column "tx_multiple_collision_counter" {
    null = false
    type = integer
  }
  column "tx_deferred_transmit_counter" {
    null = false
    type = integer
  }
  column "tx_late_collision_counter" {
    null = false
    type = integer
  }
  column "tx_excessive_collision_counter" {
    null = false
    type = integer
  }
  column "tx_frame_in_disc_counter" {
    null = false
    type = integer
  }
  column "tx_pause_packet_counter" {
    null = false
    type = integer
  }
  column "tx_q1_packet_counter" {
    null = false
    type = integer
  }
  column "tx_q2_packet_counter" {
    null = false
    type = integer
  }
  column "tx_q3_packet_counter" {
    null = false
    type = integer
  }
  column "tx_q4_packet_counter" {
    null = false
    type = integer
  }
  column "tx_q5_packet_counter" {
    null = false
    type = integer
  }
  column "rx_bytes_counter" {
    null = false
    type = bigint
  }
  column "rx_under_size_packet_counter" {
    null = false
    type = integer
  }
  column "rx_pause_packet_counter" {
    null = false
    type = integer
  }
  column "rx_64_bytes_counter" {
    null = false
    type = integer
  }
  column "rx_65_to_127_bytes_counter" {
    null = false
    type = integer
  }
  column "rx_128_to_255_bytes_counter" {
    null = false
    type = integer
  }
  column "rx_256_to_511_bytes_counter" {
    null = false
    type = integer
  }
  column "rx_512_to_1023_bytes_counter" {
    null = false
    type = integer
  }
  column "rx_1024_to_max_bytes_counter" {
    null = false
    type = integer
  }
  column "rx_over_size_packet_counter" {
    null = false
    type = integer
  }
  column "rx_jabber_packet_counter" {
    null = false
    type = integer
  }
  column "rx_alignment_error_counter" {
    null = false
    type = integer
  }
  column "rx_fcs_error_counter" {
    null = false
    type = integer
  }
  column "rx_good_packet_counter" {
    null = false
    type = bigint
  }
  column "rx_drop_packet_counter" {
    null = false
    type = integer
  }
  column "rx_unicast_packet_counter" {
    null = false
    type = integer
  }
  column "rx_multicast_packet_counter" {
    null = false
    type = integer
  }
  column "rx_broadcast_packet_counter" {
    null = false
    type = integer
  }
  column "rx_sa_change_counter" {
    null = false
    type = integer
  }
  column "rx_fragment_counter" {
    null = false
    type = integer
  }
  column "jumbo_packet_counter" {
    null = false
    type = integer
  }
  column "rx_symbol_error_counter" {
    null = false
    type = integer
  }
  column "in_range_error_counter" {
    null = false
    type = integer
  }
  column "out_range_error_counter" {
    null = false
    type = integer
  }
  column "rx_discard_counter" {
    null = false
    type = integer
  }
  column "tx_q6_packet_counter" {
    null = false
    type = integer
  }
  column "tx_q7_packet_counter" {
    null = false
    type = integer
  }
  column "tx_64_bytes_counter" {
    null = false
    type = integer
  }
  column "tx_65_to_127_bytes_counter" {
    null = false
    type = integer
  }
  column "tx_128_to_255_bytes_counter" {
    null = false
    type = integer
  }
  column "tx_256_to_511_bytes_counter" {
    null = false
    type = integer
  }
  column "tx_512_to_1023_bytes_counter" {
    null = false
    type = integer
  }
  column "tx_1024_to_max_bytes_counter" {
    null = false
    type = integer
  }
  column "link_state" {
    null = false
    type = integer
  }
  column "event_time" {
    null = false
    type = timestamptz
  }
  primary_key {
    columns = [column.vehicle_id, column.switch_id, column.zone_id, column.port_id, column.event_time]
  }
  foreign_key "vehicle_eth_stat_vehicle_id_fkey" {
    columns     = [column.vehicle_id]
    ref_columns = [table.vin_vehicle_id.column.vehicle_id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }
}
table "vehicle_incident_action" {
  schema = schema.vdata
  column "action_id" {
    null = false
    type = character_varying(36)
  }
  column "user_enabled" {
    null = true
    type = boolean
  }
  column "type" {
    null = false
    type = character_varying(36)
  }
  column "tags" {
    null = true
    type = sql("text[]")
  }
  column "vehicle_ids_policy_ids" {
    null = true
    type = sql("character varying(36)[]")
  }
  column "state" {
    null = true
    type = character_varying(20)
  }
  column "modification_time" {
    null = true
    type = timestamptz
  }
  column "creation_time" {
    null = false
    type = timestamptz
  }
  primary_key {
    columns = [column.action_id]
  }
}
table "vehicle_latest_policy_deployment" {
  schema = schema.vdata
  column "vehicle_id" {
    null = false
    type = character_varying(36)
  }
  column "policy_id" {
    null = false
    type = character_varying(36)
  }
  column "category" {
    null = false
    type = character_varying(32)
  }
  column "subtype" {
    null = false
    type = character_varying(32)
  }
  column "deployment_id" {
    null = false
    type = character_varying(36)
  }
  column "last_schedule_time" {
    null = false
    type = timestamptz
  }
  column "retry_count" {
    null = false
    type = integer
  }
  primary_key {
    columns = [column.vehicle_id, column.subtype, column.category]
  }
  foreign_key "vehicle_latest_policy_deployment_deployment_id_fkey" {
    columns     = [column.deployment_id]
    ref_columns = [table.policy_deployment.column.deployment_id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  foreign_key "vehicle_latest_policy_deployment_policy_id_fkey" {
    columns     = [column.policy_id]
    ref_columns = [table.policy.column.policy_id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }
  foreign_key "vehicle_latest_policy_deployment_vehicle_id_fkey" {
    columns     = [column.vehicle_id]
    ref_columns = [table.vin_vehicle_id.column.vehicle_id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }
}
table "vehicle_network_flow_entry" {
  schema = schema.vdata
  column "netflow_id" {
    null = false
    type = character_varying(36)
  }
  column "vehicle_id" {
    null = false
    type = character_varying(36)
  }
  column "src_mac_addr" {
    null = true
    type = character_varying(128)
  }
  column "src_ipv4" {
    null = true
    type = character_varying(32)
  }
  column "src_ipv6" {
    null = true
    type = character_varying(64)
  }
  column "src_port" {
    null = true
    type = integer
  }
  column "dst_mac_addr" {
    null = true
    type = character_varying(128)
  }
  column "dst_ipv4" {
    null = true
    type = character_varying(32)
  }
  column "dst_ipv6" {
    null = true
    type = character_varying(64)
  }
  column "dst_port" {
    null = true
    type = integer
  }
  column "protocol" {
    null = true
    type = character_varying(16)
  }
  column "event_time" {
    null = false
    type = timestamptz
  }
  column "creation_time" {
    null = false
    type = timestamptz
  }
  column "tags" {
    null = true
    type = sql("text[]")
  }
  primary_key {
    columns = [column.netflow_id]
  }
  foreign_key "vehicle_network_flow_entry_vehicle_id_fkey" {
    columns     = [column.vehicle_id]
    ref_columns = [table.vin_vehicle_id.column.vehicle_id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }
  index "vehicle_network_flow_entry_vehicle_id_netflow_id_event_time_key" {
    unique  = true
    columns = [column.vehicle_id, column.netflow_id, column.event_time]
  }
}
table "vehicle_policy_status" {
  schema = schema.vdata
  column "vehicle_id" {
    null = false
    type = character_varying(36)
  }
  column "policy_id" {
    null = false
    type = character_varying(36)
  }
  column "deployment_id" {
    null = true
    type = character_varying(36)
  }
  column "status_update_time" {
    null = true
    type = timestamptz
  }
  column "policy_name" {
    null = false
    type = character_varying(256)
  }
  column "category" {
    null = false
    type = character_varying(32)
  }
  column "subtype" {
    null = false
    type = character_varying(32)
  }
  column "downloaded_version" {
    null = true
    type = integer
  }
  column "installed_version" {
    null = true
    type = integer
  }
  column "applied_version" {
    null = true
    type = integer
  }
  column "status" {
    null = true
    type = character_varying(64)
  }
  column "state" {
    null = false
    type = character_varying(64)
  }
  column "error_msg" {
    null = true
    type = character_varying(512)
  }
  column "step" {
    null = true
    type = character_varying(32)
  }
  column "creation_time" {
    null    = false
    type    = timestamptz
    default = sql("CURRENT_TIMESTAMP")
  }
  primary_key {
    columns = [column.vehicle_id, column.policy_id, column.creation_time, column.state]
  }
  foreign_key "vehicle_policy_status_deployment_id_fkey" {
    columns     = [column.deployment_id]
    ref_columns = [table.policy_deployment.column.deployment_id]
    on_update   = CASCADE
    on_delete   = CASCADE
  }
  foreign_key "vehicle_policy_status_policy_id_fkey" {
    columns     = [column.policy_id]
    ref_columns = [table.policy.column.policy_id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }
  foreign_key "vehicle_policy_status_vehicle_id_fkey" {
    columns     = [column.vehicle_id]
    ref_columns = [table.vin_vehicle_id.column.vehicle_id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }
  index "vehicle_policy_status_vehicle_id_deployment_id_creation_tim_idx" {
    on {
      column = column.vehicle_id
    }
    on {
      column = column.deployment_id
    }
    on {
      desc   = true
      column = column.creation_time
    }
  }
}
table "vehicle_registration" {
  schema = schema.vdata
  column "vin" {
    null = false
    type = character_varying(64)
  }
  column "brand_name" {
    null = false
    type = character_varying(16)
  }
  column "unit" {
    null = false
    type = character_varying(10)
  }
  column "vehicle_id" {
    null = false
    type = character_varying(36)
  }
  column "client_id" {
    null = false
    type = character_varying(36)
  }
  primary_key {
    columns = [column.vin, column.brand_name, column.unit]
  }
}
table "vehicle_scheduled_policy_deployment" {
  schema = schema.vdata
  column "vehicle_id" {
    null = false
    type = character_varying(36)
  }
  column "policy_id" {
    null = false
    type = character_varying(36)
  }
  column "category" {
    null = false
    type = character_varying(32)
  }
  column "subtype" {
    null = false
    type = character_varying(32)
  }
  column "deployment_id" {
    null = false
    type = character_varying(36)
  }
  column "schedule_time" {
    null = false
    type = timestamptz
  }
  primary_key {
    columns = [column.vehicle_id, column.category, column.subtype, column.schedule_time]
  }
  foreign_key "vehicle_scheduled_policy_deployment_deployment_id_fkey" {
    columns     = [column.deployment_id]
    ref_columns = [table.policy_deployment.column.deployment_id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  foreign_key "vehicle_scheduled_policy_deployment_policy_id_fkey" {
    columns     = [column.policy_id]
    ref_columns = [table.policy.column.policy_id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }
  foreign_key "vehicle_scheduled_policy_deployment_vehicle_id_fkey" {
    columns     = [column.vehicle_id]
    ref_columns = [table.vin_vehicle_id.column.vehicle_id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }
}
table "vehicle_security_3rd_party_entry" {
  schema = schema.vdata
  column "domain_name" {
    null = true
    type = character_varying(255)
  }
  column "ip_addr" {
    null = true
    type = character_varying(16)
  }
  column "tag" {
    null = true
    type = character_varying(10)
  }
  column "score" {
    null = true
    type = integer
  }
  column "risk_factor" {
    null = true
    type = integer
  }
  column "ransomware" {
    null = true
    type = boolean
  }
  column "bad_domain" {
    null = true
    type = boolean
  }
  column "domain_status" {
    null = true
    type = sql("character varying(30)[]")
  }
  column "domain_creation_date" {
    null = true
    type = timestamptz
  }
  column "domain_expiration_date" {
    null = true
    type = timestamptz
  }
  column "domain_registrar_name" {
    null = true
    type = text
  }
  column "domain_registrant_name" {
    null = true
    type = text
  }
  column "domain_registrant_email" {
    null = true
    type = text
  }
  column "domain_updated_date" {
    null = true
    type = timestamptz
  }
  column "creation_time" {
    null = false
    type = timestamptz
  }
}
table "vehicle_security_incident" {
  schema = schema.vdata
  column "incident_id" {
    null = false
    type = character_varying(36)
  }
  column "attack_id" {
    null = false
    type = character_varying(64)
  }
  column "ids_service" {
    null = false
    type = character_varying(10)
  }
  column "ids_severity" {
    null = false
    type = character_varying(10)
  }
  column "user_severity" {
    null = true
    type = character_varying(10)
  }
  column "last_event_time" {
    null = true
    type = timestamptz
  }
  column "region" {
    null = true
    type = character_varying(20)
  }
  column "category" {
    null = false
    type = character_varying(10)
  }
  column "event_count" {
    null = false
    type = integer
  }
  column "action_ids" {
    null = true
    type = sql("character varying(36)[]")
  }
  column "tags" {
    null = true
    type = sql("text[]")
  }
  column "responded_by" {
    null = true
    type = character_varying(32)
  }
  column "packets_blocked" {
    null = true
    type = integer
  }
  column "modification_time" {
    null = true
    type = timestamptz
  }
  column "creation_time" {
    null = false
    type = timestamptz
  }
  primary_key {
    columns = [column.incident_id]
  }
  foreign_key "vehicle_security_incident_responded_by_fkey" {
    columns     = [column.responded_by]
    ref_columns = [table.user.column.user_id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
}
table "vehicle_states" {
  schema = schema.vdata
  column "vehicle_id" {
    null = false
    type = character_varying(36)
  }
  column "states" {
    null = false
    type = sql("character varying(32)[]")
  }
  column "creation_time" {
    null = false
    type = timestamptz
  }
  primary_key {
    columns = [column.vehicle_id, column.creation_time]
  }
  foreign_key "vehicle_states_vehicle_id_fkey" {
    columns     = [column.vehicle_id]
    ref_columns = [table.vin_vehicle_id.column.vehicle_id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }
}
table "vehicle_status_capture" {
  schema = schema.vdata
  column "policy_id" {
    null = false
    type = character_varying(36)
  }
  column "trigger_policy_id" {
    null = false
    type = integer
  }
  column "names" {
    null = false
    type = sql("text[]")
  }
  primary_key {
    columns = [column.policy_id, column.trigger_policy_id]
  }
  foreign_key "vehicle_status_capture_policy_id_fkey" {
    columns     = [column.policy_id]
    ref_columns = [table.policy.column.policy_id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }
  foreign_key "vehicle_status_capture_trigger_policy_id_fkey" {
    columns     = [column.trigger_policy_id]
    ref_columns = [table.trigger_policy.column.trigger_policy_id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
}
table "vehicle_uids_stats_attack_entry" {
  schema = schema.vdata
  column "attack_id" {
    null = false
    type = character_varying(36)
  }
  column "vehicle_id" {
    null = false
    type = character_varying(36)
  }
  column "attack_type" {
    null = false
    type = character_varying(10)
  }
  column "counter" {
    null = false
    type = integer
  }
  column "event_time" {
    null = false
    type = timestamptz
  }
  column "creation_time" {
    null = false
    type = timestamptz
  }
  primary_key {
    columns = [column.vehicle_id, column.attack_id]
  }
  foreign_key "vehicle_uids_stats_attack_entry_vehicle_id_fkey" {
    columns     = [column.vehicle_id]
    ref_columns = [table.vin_vehicle_id.column.vehicle_id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }
}
table "vehicle_vcc_stat" {
  schema = schema.vdata
  column "vehicle_id" {
    null = false
    type = character_varying(36)
  }
  column "fw_accept_packets" {
    null = false
    type = bigint
  }
  column "fw_accept_bytes" {
    null = false
    type = bigint
  }
  column "fw_drop_packets" {
    null = false
    type = bigint
  }
  column "fw_drop_bytes" {
    null = false
    type = bigint
  }
  column "apn0_tx_packets" {
    null = false
    type = bigint
  }
  column "apn0_tx_bytes" {
    null = false
    type = bigint
  }
  column "apn0_rx_packets" {
    null = false
    type = bigint
  }
  column "apn0_rx_bytes" {
    null = false
    type = bigint
  }
  column "apn1_tx_packets" {
    null = false
    type = bigint
  }
  column "apn1_tx_bytes" {
    null = false
    type = bigint
  }
  column "apn1_rx_packets" {
    null = false
    type = bigint
  }
  column "apn1_rx_bytes" {
    null = false
    type = bigint
  }
  column "apn2_tx_packets" {
    null = false
    type = bigint
  }
  column "apn2_tx_bytes" {
    null = false
    type = bigint
  }
  column "apn2_rx_packets" {
    null = false
    type = bigint
  }
  column "apn2_rx_bytes" {
    null = false
    type = bigint
  }
  column "apn3_tx_packets" {
    null = false
    type = bigint
  }
  column "apn3_tx_bytes" {
    null = false
    type = bigint
  }
  column "apn3_rx_packets" {
    null = false
    type = bigint
  }
  column "apn3_rx_bytes" {
    null = false
    type = bigint
  }
  column "sg_default_tx_packets" {
    null = false
    type = bigint
  }
  column "sg_default_tx_bytes" {
    null = false
    type = bigint
  }
  column "sg_default_rx_packets" {
    null = false
    type = bigint
  }
  column "sg_default_rx_bytes" {
    null = false
    type = bigint
  }
  column "sg_ccs_tx_packets" {
    null = false
    type = bigint
  }
  column "sg_ccs_tx_bytes" {
    null = false
    type = bigint
  }
  column "sg_ccs_rx_packets" {
    null = false
    type = bigint
  }
  column "sg_ccs_rx_bytes" {
    null = false
    type = bigint
  }
  column "sg_fota_tx_packets" {
    null = false
    type = bigint
  }
  column "sg_fota_tx_bytes" {
    null = false
    type = bigint
  }
  column "sg_fota_rx_packets" {
    null = false
    type = bigint
  }
  column "sg_fota_rx_bytes" {
    null = false
    type = bigint
  }
  column "sg_userpaid_tx_packets" {
    null = false
    type = bigint
  }
  column "sg_userpaid_tx_bytes" {
    null = false
    type = bigint
  }
  column "sg_userpaid_rx_packets" {
    null = false
    type = bigint
  }
  column "sg_userpaid_rx_bytes" {
    null = false
    type = bigint
  }
  column "sg_oempaid_tx_packets" {
    null = false
    type = bigint
  }
  column "sg_oempaid_tx_bytes" {
    null = false
    type = bigint
  }
  column "sg_oempaid_rx_packets" {
    null = false
    type = bigint
  }
  column "sg_oempaid_rx_bytes" {
    null = false
    type = bigint
  }
  column "sg_vcrm_tx_packets" {
    null = false
    type = bigint
  }
  column "sg_vcrm_tx_bytes" {
    null = false
    type = bigint
  }
  column "sg_vcrm_rx_packets" {
    null = false
    type = bigint
  }
  column "sg_vcrm_rx_bytes" {
    null = false
    type = bigint
  }
  column "sg_canids_tx_packets" {
    null = false
    type = bigint
  }
  column "sg_canids_tx_bytes" {
    null = false
    type = bigint
  }
  column "sg_canids_rx_packets" {
    null = false
    type = bigint
  }
  column "sg_canids_rx_bytes" {
    null = false
    type = bigint
  }
  column "rollover" {
    null    = true
    type    = boolean
    default = false
  }
  column "event_time" {
    null = false
    type = timestamptz
  }
  primary_key {
    columns = [column.vehicle_id, column.event_time]
  }
  foreign_key "vehicle_vcc_stat_vehicle_id_fkey" {
    columns     = [column.vehicle_id]
    ref_columns = [table.vin_vehicle_id.column.vehicle_id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }
}
table "vin_vehicle_id" {
  schema = schema.vdata
  column "vin" {
    null = false
    type = character_varying(64)
  }
  column "from_time" {
    null = false
    type = timestamptz
  }
  column "vehicle_id" {
    null = false
    type = character_varying(36)
  }
  primary_key {
    columns = [column.vin, column.from_time]
  }
  index "vin_vehicle_id_vehicle_id_key" {
    unique  = true
    columns = [column.vehicle_id]
  }
}
table "workflow_run" {
  schema = schema.vdata
  column "vehicle_id" {
    null = false
    type = character_varying(36)
  }
  column "recipe_id" {
    null = false
    type = character_varying(36)
  }
  column "workflow_name" {
    null = false
    type = text
  }
  column "start_time" {
    null = false
    type = timestamptz
  }
  column "run_id" {
    null = false
    type = integer
  }
  column "ended" {
    null = false
    type = boolean
  }
  column "last_time" {
    null = false
    type = timestamptz
  }
  column "success" {
    null = true
    type = boolean
  }
  column "reached_failure_task" {
    null = false
    type = boolean
  }
  primary_key {
    columns = [column.vehicle_id, column.recipe_id, column.workflow_name, column.start_time]
  }
  foreign_key "workflow_run_recipe_id_fkey" {
    columns     = [column.recipe_id]
    ref_columns = [table.recipe.column.policy_id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }
  foreign_key "workflow_run_vehicle_id_fkey" {
    columns     = [column.vehicle_id]
    ref_columns = [table.vin_vehicle_id.column.vehicle_id]
    on_update   = NO_ACTION
    on_delete   = CASCADE
  }
  index "workflow_run_vehicle_id_recipe_id_workflow_name_run_id_key" {
    unique  = true
    columns = [column.vehicle_id, column.recipe_id, column.workflow_name, column.run_id]
  }
}
table "workflow_template" {
  schema = schema.vdata
  column "name" {
    null = false
    type = character_varying(256)
  }
  column "categories" {
    null = true
    type = sql("character varying(32)[]")
  }
  column "description" {
    null = true
    type = character_varying(256)
  }
  column "data" {
    null = false
    type = text
  }
  column "thumbnail" {
    null = true
    type = text
  }
  column "created_by" {
    null = false
    type = character_varying(32)
  }
  column "creation_time" {
    null = false
    type = timestamptz
  }
  column "disabled" {
    null    = false
    type    = boolean
    default = false
  }
  column "disabled_by" {
    null = true
    type = character_varying(32)
  }
  column "disabled_reason" {
    null = true
    type = text
  }
  primary_key {
    columns = [column.name]
  }
  foreign_key "workflow_template_created_by_fkey" {
    columns     = [column.created_by]
    ref_columns = [table.user.column.user_id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
  foreign_key "workflow_template_disabled_by_fkey" {
    columns     = [column.disabled_by]
    ref_columns = [table.user.column.user_id]
    on_update   = NO_ACTION
    on_delete   = NO_ACTION
  }
}
schema "vdata" {
}
