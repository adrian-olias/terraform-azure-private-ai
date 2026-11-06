variable "name" {
  description = "Container name."
  type        = string
}

variable "storage_account_id" {
  description = "Storage account that holds the container."
  type        = string
}

variable "container_access_type" {
  description = "Anonymous access level: private, blob or container."
  type        = string
}
