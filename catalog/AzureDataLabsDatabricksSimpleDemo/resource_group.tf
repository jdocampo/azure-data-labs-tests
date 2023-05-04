# Resource group

module "resource_group" {
  source = "git::https://github.com/Azure/azure-data-labs-modules.git//terraform/resource-group?ref=v1.5.0&depth=1"

  basename = local.basename
  location = var.location

  tags = local.tags
}

module "resource_group_global_dns" {
  source = "git::https://github.com/Azure/azure-data-labs-modules.git//terraform/resource-group?ref=v1.5.0&depth=1"

  basename = "${local.basename}-global-dns"
  location = var.location

  count = var.enable_private_endpoints ? 1 : 0

  tags = local.tags
}
  
# Add the owner role assignment to the resource group
resource "azurerm_role_assignment" "resource_group_owner" {
  scope                = module.resource_group.id
  role_definition_name = "Owner"
  principal_id         = var.principal_id
}

resource "azurerm_role_assignment" "resource_group_global_dns_owner" {
  scope                = module.resource_group_global_dns[0].id
  role_definition_name = "Owner"
  principal_id         = var.principal_id

  count = var.enable_private_endpoints ? 1 : 0
}
