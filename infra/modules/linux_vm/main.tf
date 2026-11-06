# Azure requires an SSH key, but nobody logs in: the VM is managed with `az vm run-command`.
# The private key only lives in the remote state.
resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "azurerm_linux_virtual_machine" "this" {
  name                  = var.name
  location              = var.location
  resource_group_name   = var.resource_group_name
  size                  = var.size
  admin_username        = var.admin_username
  network_interface_ids = [var.network_interface_id]
  patch_assessment_mode = var.patch_assessment_mode
  tags                  = var.tags

  # Guardrail: SSH keys only, never passwords
  disable_password_authentication = true

  admin_ssh_key {
    username   = var.admin_username
    public_key = tls_private_key.this.public_key_openssh
  }

  os_disk {
    name                 = "${var.name}-osdisk"
    caching              = var.os_disk_caching
    storage_account_type = var.os_disk_storage_account_type
    disk_size_gb         = var.os_disk_size_gb
  }

  source_image_reference {
    publisher = var.source_image_reference.publisher
    offer     = var.source_image_reference.offer
    sku       = var.source_image_reference.sku
    version   = var.source_image_reference.version
  }

  # Guardrail: the VM reaches Storage, Key Vault and ACR with its managed identity, never with credentials
  identity {
    type = "SystemAssigned"
  }

  # Managed storage account for boot diagnostics
  boot_diagnostics {}
}
