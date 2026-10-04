###############################################################################
#  BOOTSTRAP — Variables
###############################################################################

variable "location" {
  description = "Azure region for remote state resources"
  type        = string
  default     = "spaincentral"
}

variable "resource_group_name" {
  description = "Resource Group name for Terraform state"
  type        = string
  default     = "rg-tf-bootstrap-001"
}

variable "storage_account_name" {
  description = "Storage Account name for tfstate (must be globally unique, alphanumeric only)"
  type        = string
  default     = "stterraformstate001"
}

variable "container_name" {
  description = "Blob container name for state files"
  type        = string
  default     = "tfstate"
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default = {
    Project     = "PrivateAI"
    Environment = "Lab"
    Purpose     = "Terraform-State"
    ManagedBy   = "Terraform"
  }
}
