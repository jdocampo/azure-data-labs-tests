variable "location" {
  type        = string
  description = "Location of the resource group and modules"
}

variable "prefix" {
  type        = string
  description = "Prefix for module names"
}

variable "postfix" {
  type        = string
  description = "Postfix for module names"
}

variable "aad_login" {
  description = "AAD login"
  type = object({
    name      = string
    object_id = string
    tenant_id = string
  })
  default = {
    name      = "AzureAD Admin"
    object_id = "00000000-0000-0000-0000-000000000000"
    tenant_id = "00000000-0000-0000-0000-000000000000"
  }
}

variable "jumphost_username" {
  type        = string
  description = "VM username"
  default     = "azureuser"
}

variable "jumphost_password" {
  type        = string
  description = "VM password"
  default     = "ThisIsNotVerySecure!"
}

variable "synadmin_username" {
  type        = string
  description = "The Login Name of the SQL administrator"
  default     = "sqladminuser"
}

variable "synadmin_password" {
  type        = string
  description = "The Password associated with the sql_administrator_login for the SQL administrator"
  default     = "ThisIsNotVerySecure!"
}

# Feature flags

variable "enable_private_endpoints" {
  type        = bool
  description = "Is secure enabled?"
  default     = false
}