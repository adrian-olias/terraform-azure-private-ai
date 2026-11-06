variable "name" {
  description = "Key Vault name. Globally unique, 3-24 letters, digits and hyphens."
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z][a-zA-Z0-9-]{1,22}[a-zA-Z0-9]$", var.name))
    error_message = "name must be 3-24 characters, start with a letter, end with a letter or digit, and use only letters, digits and hyphens."
  }
}

variable "resource_group_name" {
  description = "Resource group for the Key Vault."
  type        = string
}

variable "location" {
  description = "Azure region."
  type        = string
}

variable "tenant_id" {
  description = "Entra ID tenant of the Key Vault."
  type        = string
}

variable "sku_name" {
  description = "Key Vault SKU. premium adds HSM-backed keys."
  type        = string

  validation {
    condition     = contains(["standard", "premium"], var.sku_name)
    error_message = "Must be standard or premium."
  }
}

variable "purge_protection_enabled" {
  description = "Block permanent deletion during the retention period."
  type        = bool
}

variable "soft_delete_retention_days" {
  description = "Days a deleted vault stays recoverable."
  type        = number

  validation {
    condition     = var.soft_delete_retention_days >= 7 && var.soft_delete_retention_days <= 90
    error_message = "soft_delete_retention_days must be between 7 and 90."
  }
}

variable "rbac_authorization_enabled" {
  description = "Authorize with Azure RBAC instead of access policies."
  type        = bool
}

variable "public_network_access_enabled" {
  description = "Allow public network access. Off means private endpoints only."
  type        = bool
}

variable "tags" {
  description = "Tags for the Key Vault."
  type        = map(string)
  default     = {}
}
