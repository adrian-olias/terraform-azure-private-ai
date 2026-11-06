variable "name" {
  description = "VM name."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group for the VM."
  type        = string
}

variable "location" {
  description = "Azure region."
  type        = string
}

variable "network_interface_id" {
  description = "Network interface attached to the VM. It has no public IP."
  type        = string
}

variable "size" {
  description = "VM size, e.g. Standard_NC4as_T4_v3."
  type        = string
}

variable "admin_username" {
  description = "Local admin user."
  type        = string
  default     = "azureaiuser"
}

variable "source_image_reference" {
  description = "Marketplace image of the OS."
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
  default = {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
}

variable "os_disk_size_gb" {
  description = "OS disk size in GB."
  type        = number
  default     = 128

  validation {
    condition     = var.os_disk_size_gb >= 30
    error_message = "os_disk_size_gb must be at least 30."
  }
}

variable "os_disk_storage_account_type" {
  description = "OS disk type."
  type        = string
  default     = "StandardSSD_LRS"

  validation {
    condition     = contains(["Standard_LRS", "StandardSSD_LRS", "StandardSSD_ZRS", "Premium_LRS", "Premium_ZRS"], var.os_disk_storage_account_type)
    error_message = "Must be Standard_LRS, StandardSSD_LRS, StandardSSD_ZRS, Premium_LRS or Premium_ZRS."
  }
}

variable "os_disk_caching" {
  description = "OS disk caching."
  type        = string
  default     = "ReadWrite"

  validation {
    condition     = contains(["None", "ReadOnly", "ReadWrite"], var.os_disk_caching)
    error_message = "Must be None, ReadOnly or ReadWrite."
  }
}

variable "patch_assessment_mode" {
  description = "How missing OS patches are assessed."
  type        = string
  default     = "AutomaticByPlatform"

  validation {
    condition     = contains(["AutomaticByPlatform", "ImageDefault"], var.patch_assessment_mode)
    error_message = "Must be AutomaticByPlatform or ImageDefault."
  }
}

variable "tags" {
  description = "Tags for the VM."
  type        = map(string)
  default     = {}
}
