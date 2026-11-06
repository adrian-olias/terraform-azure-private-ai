# Shared by every file in this environment. Each other file calls one module and is named after it.

locals {
  location = var.location
  tags     = var.tags
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
