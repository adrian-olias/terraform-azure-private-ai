virtual_machines = {
  vm-privateai-lab = {
    name                         = "vm-privateai-lab"
    resource_group_key           = "rg-privateai-lab"
    network_interface_key        = "nic-privateai-lab-vm"
    size                         = "Standard_NC4as_T4_v3" # NVIDIA T4
    admin_username               = "azureaiuser"
    patch_assessment_mode        = "AutomaticByPlatform"
    os_disk_size_gb              = 128
    os_disk_storage_account_type = "StandardSSD_LRS"
    os_disk_caching              = "ReadWrite"

    source_image_reference = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts-gen2"
      version   = "latest"
    }
  }
}
