###############################################################################
#  MODULE environment_group — Private Linux VM + Managed Identity + SSH Key
###############################################################################

# ─── Generate SSH key pair ────────────────────────────────────────────────────

resource "tls_private_key" "vm_ssh" {
  algorithm = var.vm_ssh_key_algorithm
  rsa_bits  = var.vm_ssh_key_rsa_bits
}

# ─── Store SSH private key in Key Vault ───────────────────────────────────────

resource "azurerm_key_vault_secret" "ssh_private_key" {
  name         = "${var.vm_name}-ssh-private-key"
  value        = tls_private_key.vm_ssh.private_key_pem
  key_vault_id = azurerm_key_vault.main.id
  content_type = "application/x-pem-file"
  tags         = var.tags

  depends_on = [
    azurerm_role_assignment.kv_admin
  ]
}

# ─── Store SSH public key in Key Vault ────────────────────────────────────────

resource "azurerm_key_vault_secret" "ssh_public_key" {
  name         = "${var.vm_name}-ssh-public-key"
  value        = tls_private_key.vm_ssh.public_key_openssh
  key_vault_id = azurerm_key_vault.main.id
  content_type = "text/plain"
  tags         = var.tags

  depends_on = [
    azurerm_role_assignment.kv_admin
  ]
}

# ─── Network Interface (No Public IP) ─────────────────────────────────────────

resource "azurerm_network_interface" "vm" {
  name                = "nic-${var.vm_name}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  tags                = var.tags

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.compute.id
    private_ip_address_allocation = "Dynamic"
    # No public_ip_address_id: VM is isolated with no public exposure
  }
}

# ─── Linux Virtual Machine ────────────────────────────────────────────────────

resource "azurerm_linux_virtual_machine" "ai_engine" {
  name                = var.vm_name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  size                = var.vm_size
  admin_username      = var.vm_admin_username

  network_interface_ids = [azurerm_network_interface.vm.id]

  # ─── SSH-only authentication (no passwords) ──────────────────────────────
  disable_password_authentication = true

  admin_ssh_key {
    username   = var.vm_admin_username
    public_key = tls_private_key.vm_ssh.public_key_openssh
  }

  # ─── OS Disk ──────────────────────────────────────────────────────────────
  os_disk {
    name                 = "osdisk-${var.vm_name}"
    caching              = var.vm_os_disk_caching
    storage_account_type = var.vm_os_disk_storage_type
    disk_size_gb         = var.vm_os_disk_size_gb
  }

  # ─── OS Image ─────────────────────────────────────────────────────────────
  source_image_reference {
    publisher = var.vm_image_publisher
    offer     = var.vm_image_offer
    sku       = var.vm_image_sku
    version   = var.vm_image_version
  }

  # ─── System-Assigned Managed Identity ─────────────────────────────────────
  identity {
    type = "SystemAssigned"
  }

  # ─── Cloud-init ────────────────────────────────────────────────────────────
  # GPU drivers take 10-15 min to compile; run manually via Bastion for visibility.
  # See: cloud-init/bastion-install-gpu.sh
  # custom_data = base64encode(file("${path.module}/cloud-init/bastion-install-gpu.sh"))

  tags = var.tags
}
