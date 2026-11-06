variable "name" {
  description = "Network interface name."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group for the network interface."
  type        = string
}

variable "location" {
  description = "Azure region."
  type        = string
}

variable "subnet_id" {
  description = "Subnet for the private IP."
  type        = string
}

variable "private_ip_address" {
  description = "Static private IP. Leave null to let Azure assign one dynamically."
  type        = string
  default     = null

  validation {
    condition     = var.private_ip_address == null || can(cidrhost("${coalesce(var.private_ip_address, "0.0.0.0")}/32", 0))
    error_message = "private_ip_address must be a valid IPv4 address."
  }
}

variable "ip_configuration_name" {
  description = "Name of the IP configuration."
  type        = string
  default     = "internal"
}

variable "tags" {
  description = "Tags for the network interface."
  type        = map(string)
  default     = {}
}
