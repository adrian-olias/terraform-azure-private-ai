variable "name" {
  description = "Registry name. Globally unique, 5-50 letters and digits."
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9]{5,50}$", var.name))
    error_message = "name must be 5-50 letters and digits."
  }
}

variable "resource_group_name" {
  description = "Resource group for the registry."
  type        = string
}

variable "location" {
  description = "Azure region."
  type        = string
}

variable "sku" {
  description = "Registry SKU. Only Premium supports private endpoints."
  type        = string

  validation {
    condition     = contains(["Basic", "Standard", "Premium"], var.sku)
    error_message = "Must be Basic, Standard or Premium."
  }
}

variable "admin_enabled" {
  description = "Enable the shared admin user. Off means Entra ID and RBAC only."
  type        = bool
}

variable "tags" {
  description = "Tags for the registry."
  type        = map(string)
  default     = {}
}
