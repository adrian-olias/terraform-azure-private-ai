variable "name" {
  description = "Zone name, e.g. privatelink.blob.core.windows.net."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group for the zone."
  type        = string
}

variable "tags" {
  description = "Tags for the zone."
  type        = map(string)
  default     = {}
}
