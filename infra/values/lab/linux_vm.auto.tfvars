virtual_machines = {
  vm-privateai-lab = {
    name                         = "vm-privateai-lab"
    resource_group_key           = "rg-privateai-lab"
    network_interface_key        = "nic-privateai-lab-vm"
    size                         = "Standard_D4s_v4" # 4 vCPU, 16 GB: enough for a 3B model on CPU
    admin_username               = "azureaiuser"
    patch_assessment_mode        = "AutomaticByPlatform"
    os_disk_size_gb              = 128
    os_disk_storage_account_type = "StandardSSD_LRS"
    os_disk_caching              = "ReadWrite"
    custom_data_file             = "../../scripts/cloud-init.yaml" # first-boot script: installs Docker and the Azure CLI

    source_image_reference = {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-jammy"
      sku       = "22_04-lts-gen2"
      version   = "latest"
    }
  }
}
