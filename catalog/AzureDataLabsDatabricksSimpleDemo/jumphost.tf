# Bastion

module "bastion" {
  source = "git::https://github.com/Azure/azure-data-labs-modules.git//terraform/bastion-host?ref=main"

  basename            = local.basename
  resource_group_name = var.resource_group_name
  location            = var.location
  subnet_id           = var.enable_jumphost ? module.subnet_bastion[0].id : null

  module_enabled = var.enable_jumphost

  tags = local.tags
}

# Virtual machine

module "virtual_machine_jumphost" {
  source = "git::https://github.com/Azure/azure-data-labs-modules.git//terraform/virtual-machine?ref=main"

  basename            = local.basename
  resource_group_name = var.resource_group_name
  location            = var.location
  subnet_id           = var.enable_private_endpoints ? module.subnet_default[0].id : null
  jumphost_username   = var.jumphost_username
  jumphost_password   = var.jumphost_password

  module_enabled = var.enable_jumphost

  tags = local.tags
}