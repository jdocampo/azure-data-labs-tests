# Synapse workspace

module "synapse_workspace" {
  #source = "github.com/Azure/azure-data-labs-modules/terraform/synapse/synapse-workspace"
  source = "git::https://github.com/Azure/azure-data-labs-modules.git//terraform/synapse/synapse-workspace?ref=v1.5.0-beta"

  basename             = local.basename
  resource_group_name  = module.resource_group.name
  location             = module.resource_group.location
  adls_id              = local.enable_synapse_workspace ? module.storage_account_syn.adls_id : "null"
  storage_account_id   = local.enable_synapse_workspace ? module.storage_account_syn.id : "null"
  storage_account_name = local.enable_synapse_workspace ? module.storage_account_syn.name : "null"

  subnet_id                = local.enable_private_endpoints ? module.subnet_default[0].id : null
  private_dns_zone_ids_sql = local.enable_private_endpoints ? [module.private_dns_zones[0].list["privatelink.sql.azuresynapse.net"].id] : null
  private_dns_zone_ids_dev = local.enable_private_endpoints ? [module.private_dns_zones[0].list["privatelink.dev.azuresynapse.net"].id] : null

  synadmin_username = var.synadmin_username
  synadmin_password = var.synadmin_password

  aad_login = {
    name      = var.aad_login.name
    object_id = var.aad_login.object_id
    tenant_id = var.aad_login.tenant_id
  }

  module_enabled      = local.enable_synapse_workspace
  is_private_endpoint = local.enable_private_endpoints

  tags = local.tags
}

# Synapse Private Link Hub

module "synapse_private_link_hub" {
  #source = "github.com/Azure/azure-data-labs-modules/terraform/synapse/synapse-private-link-hub"
  source = "git::https://github.com/Azure/azure-data-labs-modules.git//terraform/synapse/synapse-private-link-hub?ref=v1.5.0-beta"

  basename            = local.safe_basename
  resource_group_name = module.resource_group.name
  location            = local.location

  subnet_id            = local.enable_private_endpoints ? module.subnet_default[0].id : null
  private_dns_zone_ids = local.enable_private_endpoints ? [module.private_dns_zones[0].list["privatelink.azuresynapse.net"].id] : null

  module_enabled = local.enable_synapse_workspace && local.enable_private_endpoints

  tags = local.tags
}

# Synapse Spark pool

module "synapse_spark_pool" {
  source = "github.com/Azure/azure-data-labs-modules.git//terraform/synapse/synapse-spark-pool"

  basename             = local.safe_basename
  synapse_workspace_id = module.synapse_workspace.id

  module_enabled = local.enable_machine_learning_synapse_spark
}