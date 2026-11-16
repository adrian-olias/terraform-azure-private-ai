variable "name" {
  description = "Link name."
  type        = string
}

variable "private_dns_zone_id" {
  description = "ID of the private DNS zone to link."
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

