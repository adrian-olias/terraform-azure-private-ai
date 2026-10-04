###############################################################################
#  MANIFESTS — Environment Variables (Lab)
#
#  No secrets or personal data in this file.
#  Sensitive values (subscription_id, deployer_ip) must be provided via:
#    - terraform.tfvars (git-ignored) — copy from terraform.tfvars.example
#    - Environment variables: TF_VAR_subscription_id / ARM_SUBSCRIPTION_ID
###############################################################################

# ─── General ──────────────────────────────────────────────────────────────────

variable "location" {
  description = "Azure region"
  type        = string
  default     = "spaincentral"
}

variable "resource_group_name" {
  description = "Resource Group name"
  type        = string
  default     = "rg-ai-lab-001"
}

variable "subscription_id" {
  description = "Azure Subscription ID — pass via TF_VAR_subscription_id or terraform.tfvars (git-ignored)"
  type        = string
  # No default — must be provided explicitly to avoid credential exposure
}

variable "tags" {
  description = "Common tags applied to all resources"
  type        = map(string)
  default = {
    Project     = "PrivateAI"
    Environment = "Lab"
    ManagedBy   = "Terraform"
  }
}

variable "deployer_ip" {
  description = "Your current public IP — grants temporary access to Key Vault and Storage Account during terraform apply"
  type        = string
  # No default — pass via terraform.tfvars (git-ignored) or -var flag
  # Get your IP with: curl -s ifconfig.me
}

# ─── Networking ───────────────────────────────────────────────────────────────

variable "vnet_name" {
  description = "Virtual Network name"
  type        = string
  default     = "vnet-ai-lab"
}

variable "vnet_address_space" {
  description = "VNet address space"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnet_name" {
  description = "VM Subnet name"
  type        = string
  default     = "snet-compute-001"
}

variable "subnet_address_prefixes" {
  description = "VM Subnet prefix"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "subnet_pe_name" {
  description = "Private Endpoint Subnet name"
  type        = string
  default     = "snet-private-endpoint"
}

variable "subnet_pe_address_prefixes" {
  description = "Private Endpoint Subnet prefix"
  type        = list(string)
  default     = ["10.0.2.0/24"]
}

variable "nsg_name" {
  description = "Network Security Group name"
  type        = string
  default     = "nsg-ai-lab"
}

# ─── Storage ──────────────────────────────────────────────────────────────────

variable "storage_account_prefix" {
  description = "Storage Account prefix (suffix added automatically for global uniqueness)"
  type        = string
  default     = "stailab"
}

variable "storage_account_tier" {
  description = "Storage Account tier"
  type        = string
  default     = "Standard"
}

variable "storage_account_replication_type" {
  description = "Storage Account replication type"
  type        = string
  default     = "LRS"
}

variable "storage_account_kind" {
  description = "Storage Account kind"
  type        = string
  default     = "StorageV2"
}

variable "storage_account_access_tier" {
  description = "Storage Account access tier"
  type        = string
  default     = "Hot"
}

variable "storage_min_tls_version" {
  description = "Minimum TLS version for Storage Account"
  type        = string
  default     = "TLS1_2"
}

variable "storage_container_name" {
  description = "Blob container name for documents"
  type        = string
  default     = "documents"
}

# ─── ACR (Azure Container Registry) ──────────────────────────────────────────

variable "acr_name" {
  description = "Azure Container Registry name (globally unique, alphanumeric only)"
  type        = string
  default     = "acrailab001"
}

variable "acr_sku" {
  description = "ACR SKU (Basic, Standard, Premium)"
  type        = string
  default     = "Basic"
}

# ─── Key Vault ────────────────────────────────────────────────────────────────

variable "key_vault_name" {
  description = "Key Vault name (globally unique)"
  type        = string
  default     = "kv-ai-lab-001"
}

variable "key_vault_sku" {
  description = "Key Vault SKU (standard or premium)"
  type        = string
  default     = "standard"
}

variable "key_vault_purge_protection" {
  description = "Enable purge protection on Key Vault (false for lab)"
  type        = bool
  default     = false
}

variable "key_vault_soft_delete_retention_days" {
  description = "Key Vault soft delete retention days"
  type        = number
  default     = 7
}

# ─── Compute (Private VM) ─────────────────────────────────────────────────────

variable "vm_name" {
  description = "VM name"
  type        = string
  default     = "vm-ai-engine-001"
}

variable "vm_size" {
  description = "VM size"
  type        = string
  default     = "Standard_NC4as_T4_v3"
}

variable "vm_os_disk_size_gb" {
  description = "OS disk size in GB"
  type        = number
  default     = 128
}

variable "vm_os_disk_caching" {
  description = "OS disk caching policy"
  type        = string
  default     = "ReadWrite"
}

variable "vm_os_disk_storage_type" {
  description = "OS disk storage type"
  type        = string
  default     = "StandardSSD_LRS"
}

variable "vm_image_publisher" {
  description = "OS image publisher"
  type        = string
  default     = "Canonical"
}

variable "vm_image_offer" {
  description = "OS image offer"
  type        = string
  default     = "0001-com-ubuntu-server-jammy"
}

variable "vm_image_sku" {
  description = "OS image SKU"
  type        = string
  default     = "22_04-lts-gen2"
}

variable "vm_image_version" {
  description = "OS image version"
  type        = string
  default     = "latest"
}

variable "vm_admin_username" {
  description = "VM admin username"
  type        = string
  default     = "azureaiuser"
}

variable "vm_ssh_key_algorithm" {
  description = "SSH key algorithm (RSA, ECDSA, ED25519)"
  type        = string
  default     = "RSA"
}

variable "vm_ssh_key_rsa_bits" {
  description = "RSA key bits"
  type        = number
  default     = 4096
}
