variable "name" {
  description = "Private endpoint name, e.g. pe-stprivateailab1234."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group for the endpoint."
  type        = string
}

variable "location" {
  description = "Azure region."
  type        = string
}

variable "subnet_id" {
  description = "Subnet for the endpoint."
  type        = string
}

variable "resource_id" {
  description = "ID of the resource to expose privately."
  type        = string
}

variable "subresource" {
  description = "Target sub-resource, e.g. blob or vault."
  type        = string
}

variable "private_dns_zone_id" {
  description = "Private DNS zone where the endpoint registers its IP."
  type        = string
}

variable "network_interface_name" {
  description = "Name of the endpoint's network interface. Defaults to <name>-nic."
  type        = string
  default     = null
}

variable "private_dns_zone_group_name" {
  description = "Name of the DNS zone group."
  type        = string
  default     = "default"
}

variable "tags" {
  description = "Tags for the endpoint."
  type        = map(string)
  default     = {}
}
