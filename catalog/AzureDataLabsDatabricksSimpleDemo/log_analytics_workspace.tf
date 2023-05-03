module "log_analytics_workspace" {
  source              = "git::https://github.com/Azure/azure-data-labs-modules.git//terraform/log-analytics/log-analytics-workspace?ref=v1.5.0&depth=1"
  basename            = local.basename
  resource_group_name = var.resource_group_name
  location            = var.location

  internet_ingestion_enabled = !var.enable_private_endpoints
  internet_query_enabled     = !var.enable_private_endpoints

  tags = local.tags
}