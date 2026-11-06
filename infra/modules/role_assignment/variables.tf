variable "scope" {
  description = "Resource ID the role applies to."
  type        = string
}

variable "role_definition_name" {
  description = "Built-in role name, e.g. AcrPull. Use the narrowest role that works."
  type        = string
}

variable "principal_id" {
  description = "Object ID of the identity receiving the role."
  type        = string
}

variable "principal_type" {
  description = "Type of identity receiving the role."
  type        = string
  default     = "ServicePrincipal"

  validation {
    condition     = contains(["ServicePrincipal", "User", "Group"], var.principal_type)
    error_message = "Must be ServicePrincipal, User or Group."
  }
}
