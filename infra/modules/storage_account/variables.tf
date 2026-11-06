variable "name" {
  description = "Storage account name. Globally unique, 3-24 lowercase letters and digits."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9]{3,24}$", var.name))
    error_message = "name must be 3-24 lowercase letters and digits."
  }
}

variable "resource_group_name" {
  description = "Resource group for the storage account."
  type        = string
}

variable "location" {
  description = "Azure region."
  type        = string
}

variable "account_kind" {
  description = "Storage account kind."
  type        = string

  validation {
    condition     = contains(["StorageV2", "BlockBlobStorage", "FileStorage"], var.account_kind)
    error_message = "Must be StorageV2, BlockBlobStorage or FileStorage."
  }
}

variable "account_tier" {
  description = "Performance tier."
  type        = string

  validation {
    condition     = contains(["Standard", "Premium"], var.account_tier)
    error_message = "Must be Standard or Premium."
  }
}

variable "replication_type" {
  description = "Replication type."
  type        = string

  validation {
    condition     = contains(["LRS", "ZRS", "GRS", "RAGRS", "GZRS", "RAGZRS"], var.replication_type)
    error_message = "Must be LRS, ZRS, GRS, RAGRS, GZRS or RAGZRS."
  }
}

variable "public_network_access_enabled" {
  description = "Allow public network access. Off means private endpoints only."
  type        = bool
}

variable "shared_access_key_enabled" {
  description = "Allow account keys and SAS tokens. Off means Entra ID only."
  type        = bool
}

variable "allow_nested_items_to_be_public" {
  description = "Allow anonymous access to blobs."
  type        = bool
}

variable "min_tls_version" {
  description = "Minimum TLS version, e.g. TLS1_2."
  type        = string
}

variable "tags" {
  description = "Tags for the storage account."
  type        = map(string)
  default     = {}
}
