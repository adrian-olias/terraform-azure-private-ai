variable "location" {
  description = "Azure region for the state backend."
  type        = string
  default     = "spaincentral"
}

variable "resource_group_name" {
  description = "Resource group for the state backend."
  type        = string
  default     = "rg-privateai-tfstate"
}

variable "storage_account_prefix" {
  description = "Storage account name prefix; a random 4-character suffix is appended."
  type        = string
  default     = "stprivateaitfstate"
}

variable "tags" {
  description = "Tags for the state backend."
  type        = map(string)
  default = {
    Project   = "privateai"
    Owner     = "adrian-olias"
    ManagedBy = "terraform"
  }
}
