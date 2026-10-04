###############################################################################
#  MODULE environment_group — Input Variables
###############################################################################

# ─── General ──────────────────────────────────────────────────────────────────

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group name"
  type        = string
}

variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

variable "tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
  default     = {}
}

variable "deployer_ip" {
  description = "Deployer public IP — grants temporary Key Vault and Storage access during terraform apply"
  type        = string
}

# ─── Networking ───────────────────────────────────────────────────────────────

variable "vnet_name" {
  description = "Virtual Network name"
  type        = string
}

variable "vnet_address_space" {
  description = "VNet address space"
  type        = list(string)
}

variable "subnet_name" {
  description = "VM Subnet name"
  type        = string
}

variable "subnet_address_prefixes" {
  description = "VM Subnet prefix"
  type        = list(string)
}

variable "subnet_pe_name" {
  description = "Private Endpoint Subnet name"
  type        = string
}

variable "subnet_pe_address_prefixes" {
  description = "Private Endpoint Subnet prefix"
  type        = list(string)
}

variable "nsg_name" {
  description = "Network Security Group name"
  type        = string
}

# ─── Storage ──────────────────────────────────────────────────────────────────

variable "storage_account_prefix" {
  description = "Storage Account prefix (random suffix added for global uniqueness)"
  type        = string
}

variable "storage_account_tier" {
  description = "Storage Account tier (Standard or Premium)"
  type        = string
}

variable "storage_account_replication_type" {
  description = "Storage Account replication type (LRS, GRS, ZRS, etc.)"
  type        = string
}

variable "storage_account_kind" {
  description = "Storage Account kind (StorageV2, BlobStorage, etc.)"
  type        = string
}

variable "storage_account_access_tier" {
  description = "Storage Account access tier (Hot or Cool)"
  type        = string
}

variable "storage_min_tls_version" {
  description = "Minimum TLS version for Storage Account"
  type        = string
}

variable "storage_container_name" {
  description = "Blob container name"
  type        = string
}

# ─── ACR ──────────────────────────────────────────────────────────────────────

variable "acr_name" {
  description = "Azure Container Registry name"
  type        = string
}

variable "acr_sku" {
  description = "ACR SKU (Basic, Standard, Premium)"
  type        = string
}

# ─── Key Vault ────────────────────────────────────────────────────────────────

variable "key_vault_name" {
  description = "Key Vault name"
  type        = string
}

variable "key_vault_sku" {
  description = "Key Vault SKU (standard or premium)"
  type        = string
}

variable "key_vault_purge_protection" {
  description = "Enable purge protection on Key Vault"
  type        = bool
}

variable "key_vault_soft_delete_retention_days" {
  description = "Key Vault soft delete retention days"
  type        = number
}

# ─── Compute ──────────────────────────────────────────────────────────────────

variable "vm_name" {
  description = "VM name"
  type        = string
}

variable "vm_size" {
  description = "VM size / SKU"
  type        = string
}

variable "vm_os_disk_size_gb" {
  description = "OS disk size in GB"
  type        = number
}

variable "vm_os_disk_caching" {
  description = "OS disk caching policy (None, ReadOnly, ReadWrite)"
  type        = string
}

variable "vm_os_disk_storage_type" {
  description = "OS disk storage type (Standard_LRS, Premium_LRS, etc.)"
  type        = string
}

variable "vm_image_publisher" {
  description = "OS image publisher"
  type        = string
}

variable "vm_image_offer" {
  description = "OS image offer"
  type        = string
}

variable "vm_image_sku" {
  description = "OS image SKU"
  type        = string
}

variable "vm_image_version" {
  description = "OS image version"
  type        = string
}

variable "vm_admin_username" {
  description = "VM admin username"
  type        = string
}

variable "vm_ssh_key_algorithm" {
  description = "SSH key algorithm (RSA, ECDSA, ED25519)"
  type        = string
}

variable "vm_ssh_key_rsa_bits" {
  description = "RSA key bits"
  type        = number
}
