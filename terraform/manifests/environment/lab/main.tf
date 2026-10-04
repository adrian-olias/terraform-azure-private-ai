###############################################################################
#  MANIFESTS — Main: invokes the environment_group module
###############################################################################

module "environment_group" {
  source = "../../../modules/environment_group"

  # ─── General ───────────────────────────────────────────────────────────────
  location            = var.location
  resource_group_name = var.resource_group_name
  subscription_id     = var.subscription_id
  tags                = var.tags
  deployer_ip         = var.deployer_ip

  # ─── Networking ────────────────────────────────────────────────────────────
  vnet_name                  = var.vnet_name
  vnet_address_space         = var.vnet_address_space
  subnet_name                = var.subnet_name
  subnet_address_prefixes    = var.subnet_address_prefixes
  subnet_pe_name             = var.subnet_pe_name
  subnet_pe_address_prefixes = var.subnet_pe_address_prefixes
  nsg_name                   = var.nsg_name

  # ─── Storage ───────────────────────────────────────────────────────────────
  storage_account_prefix           = var.storage_account_prefix
  storage_account_tier             = var.storage_account_tier
  storage_account_replication_type = var.storage_account_replication_type
  storage_account_kind             = var.storage_account_kind
  storage_account_access_tier      = var.storage_account_access_tier
  storage_min_tls_version          = var.storage_min_tls_version
  storage_container_name           = var.storage_container_name

  # ─── ACR ───────────────────────────────────────────────────────────────────
  acr_name = var.acr_name
  acr_sku  = var.acr_sku

  # ─── Key Vault ─────────────────────────────────────────────────────────────
  key_vault_name                       = var.key_vault_name
  key_vault_sku                        = var.key_vault_sku
  key_vault_purge_protection           = var.key_vault_purge_protection
  key_vault_soft_delete_retention_days = var.key_vault_soft_delete_retention_days

  # ─── Compute ───────────────────────────────────────────────────────────────
  vm_name                 = var.vm_name
  vm_size                 = var.vm_size
  vm_os_disk_size_gb      = var.vm_os_disk_size_gb
  vm_os_disk_caching      = var.vm_os_disk_caching
  vm_os_disk_storage_type = var.vm_os_disk_storage_type
  vm_image_publisher      = var.vm_image_publisher
  vm_image_offer          = var.vm_image_offer
  vm_image_sku            = var.vm_image_sku
  vm_image_version        = var.vm_image_version
  vm_admin_username       = var.vm_admin_username
  vm_ssh_key_algorithm    = var.vm_ssh_key_algorithm
  vm_ssh_key_rsa_bits     = var.vm_ssh_key_rsa_bits
}
