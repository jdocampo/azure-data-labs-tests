# Data Factory

module "data_factory" {
  source = "git::https://github.com/Azure/azure-data-labs-modules.git//terraform/data-factory/data-factory?ref=main"

  basename            = local.basename
  resource_group_name = var.resource_group_name
  location            = var.location

  subnet_id                   = var.enable_private_endpoints ? module.subnet_default[0].id : null
  private_dns_zone_ids_df     = var.enable_private_endpoints ? [module.private_dns_zones[0].list["privatelink.datafactory.azure.net"].id] : null
  private_dns_zone_ids_portal = var.enable_private_endpoints ? [module.private_dns_zones[0].list["privatelink.adf.azure.com"].id] : null

  module_enabled                = var.enable_data_factory
  is_private_endpoint           = var.enable_private_endpoints
  public_network_access_enabled = var.public_network_enabled

  tags = local.tags
}