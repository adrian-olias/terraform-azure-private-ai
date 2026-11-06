variable "name" {
  description = "Link name."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group of the private DNS zone."
  type        = string
}

variable "private_dns_zone_name" {
  description = "Private DNS zone to link."
  type        = string
}

variable "virtual_network_id" {
  description = "Virtual network to link to the zone."
  type        = string
}

variable "registration_enabled" {
  description = "Auto-register the VNet's VMs in the zone. Keep false for privatelink zones."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags for the link."
  type        = map(string)
  default     = {}
}
