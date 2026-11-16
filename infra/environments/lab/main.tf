# Shared by every file in this environment. Each other file calls one module and is named after it.

locals {
  tags = var.tags
}

data "azurerm_client_config" "current" {}

# Suffix for names that must be globally unique (Storage, Key Vault, ACR)
resource "random_string" "suffix" {
  length  = var.suffix_length
  upper   = false
  special = false
}

variable "location" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "suffix_length" {
  type = number
}

# Public IPs allowed to reach Storage and Key Vault from outside the VNet, to upload documents and set
# secrets. Not in a value file on purpose: pass it at apply time. Empty keeps both private-endpoint only
variable "operator_ips" {
  type    = list(string)
  default = []
}
