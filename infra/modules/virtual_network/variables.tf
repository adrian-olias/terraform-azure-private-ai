variable "name" {
  description = "Virtual network name."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group for the virtual network."
  type        = string
}

variable "location" {
  description = "Azure region."
  type        = string
}

variable "address_space" {
  description = "Address spaces of the virtual network, e.g. [\"10.1.0.0/16\"]."
  type        = list(string)

  validation {
    condition     = alltrue([for cidr in var.address_space : can(cidrhost(cidr, 0))])
    error_message = "Every address space must be a valid CIDR, e.g. 10.1.0.0/16."
  }
}

variable "tags" {
  description = "Tags for the virtual network."
  type        = map(string)
  default     = {}
}
