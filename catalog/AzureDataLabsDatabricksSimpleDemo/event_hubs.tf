module "event_hubs_namespace" {
  source = "git::https://github.com/Azure/azure-data-labs-modules.git//terraform/event-hubs/event-hubs-namespace?ref=main"

  basename            = local.basename
  resource_group_name = var.resource_group_name
  location            = var.location

  subnet_id            = var.enable_private_endpoints ? module.subnet_default[0].id : null
  private_dns_zone_ids = var.enable_private_endpoints ? [module.private_dns_zones[0].list["privatelink.servicebus.windows.net"].id] : null

  module_enabled                = var.enable_event_hub_namespace
  is_private_endpoint           = var.enable_private_endpoints
  public_network_access_enabled = var.public_network_enabled

  tags = local.tags
}

module "event_hubs" {
  source = "git::https://github.com/Azure/azure-data-labs-modules.git//terraform/event-hubs/event-hubs?ref=main"

  basename            = local.basename
  resource_group_name = var.resource_group_name
  namespace_name      = var.enable_event_hub_namespace ? module.event_hubs_namespace.name : local.basename

  module_enabled = var.enable_event_hub_namespace
}