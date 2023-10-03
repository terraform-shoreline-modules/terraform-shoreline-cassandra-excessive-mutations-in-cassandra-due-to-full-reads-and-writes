resource "shoreline_notebook" "excessive_mutations_in_cassandra_due_to_full_reads_and_writes" {
  name       = "excessive_mutations_in_cassandra_due_to_full_reads_and_writes"
  data       = file("${path.module}/data/excessive_mutations_in_cassandra_due_to_full_reads_and_writes.json")
  depends_on = [shoreline_action.invoke_optimize_schema_cache_storage_restart_service]
}

resource "shoreline_file" "optimize_schema_cache_storage_restart_service" {
  name             = "optimize_schema_cache_storage_restart_service"
  input_file       = "${path.module}/data/optimize_schema_cache_storage_restart_service.sh"
  md5              = filemd5("${path.module}/data/optimize_schema_cache_storage_restart_service.sh")
  description      = "Optimize Cassandra query performance to reduce the number of full reads and writes, and minimize the number of mutations caused by these operations. This can involve restructuring the database schema, introducing caching layers, or using alternative data storage solutions."
  destination_path = "/agent/scripts/optimize_schema_cache_storage_restart_service.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_optimize_schema_cache_storage_restart_service" {
  name        = "invoke_optimize_schema_cache_storage_restart_service"
  description = "Optimize Cassandra query performance to reduce the number of full reads and writes, and minimize the number of mutations caused by these operations. This can involve restructuring the database schema, introducing caching layers, or using alternative data storage solutions."
  command     = "`chmod +x /agent/scripts/optimize_schema_cache_storage_restart_service.sh && /agent/scripts/optimize_schema_cache_storage_restart_service.sh`"
  params      = ["DATABASE_NAME","SCHEMA_NAME","STORAGE_NAME","CACHE_NAME"]
  file_deps   = ["optimize_schema_cache_storage_restart_service"]
  enabled     = true
  depends_on  = [shoreline_file.optimize_schema_cache_storage_restart_service]
}

