module "linux_vm" {
  source   = "../../modules/linux_vm"
  for_each = var.virtual_machines

  name                         = each.value.name
  resource_group_name          = module.resource_group[each.value.resource_group_key].name
  location                     = local.location
  network_interface_id         = module.network_interface[each.value.network_interface_key].id
  size                         = each.value.size
  admin_username               = each.value.admin_username
  patch_assessment_mode        = each.value.patch_assessment_mode
  os_disk_size_gb              = each.value.os_disk_size_gb
  os_disk_storage_account_type = each.value.os_disk_storage_account_type
  os_disk_caching              = each.value.os_disk_caching
  source_image_reference       = each.value.source_image_reference
  tags                         = merge(local.tags, each.value.tags)
}

variable "virtual_machines" {
  type = map(object({
    name                         = string
    resource_group_key           = string
    network_interface_key        = string
    size                         = string
    admin_username               = string
    patch_assessment_mode        = string
    os_disk_size_gb              = number
    os_disk_storage_account_type = string
    os_disk_caching              = string
    tags                         = optional(map(string), {})

    source_image_reference = object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    })
  }))
}
