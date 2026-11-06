variable "name" {
  description = "Subnet name."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group of the virtual network."
  type        = string
}

variable "virtual_network_name" {
  description = "Virtual network the subnet belongs to."
  type        = string
}

variable "address_prefix" {
  description = "Subnet CIDR, e.g. 10.1.1.0/24."
  type        = string

  validation {
    condition     = can(cidrhost(var.address_prefix, 0))
    error_message = "address_prefix must be a valid CIDR, e.g. 10.1.1.0/24."
  }
}

variable "default_outbound_access_enabled" {
  description = "Keep Azure's implicit outbound internet access. Disable it and use a NAT Gateway in production."
  type        = bool
  default     = false
}

variable "private_endpoint_network_policies" {
  description = "Whether NSGs and route tables apply to private endpoints in this subnet."
  type        = string
  default     = "Enabled"

  validation {
    condition     = contains(["Disabled", "Enabled", "NetworkSecurityGroupEnabled", "RouteTableEnabled"], var.private_endpoint_network_policies)
    error_message = "Must be Disabled, Enabled, NetworkSecurityGroupEnabled or RouteTableEnabled."
  }
}
