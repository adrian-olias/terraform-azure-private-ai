module "container_registry" {
  source   = "../../modules/container_registry"
  for_each = var.container_registries

  name                = "${each.value.name}${random_string.suffix.result}"
  resource_group_name = module.resource_group[each.value.resource_group_key].name
  location            = local.location
  admin_enabled       = each.value.admin_enabled

  sku = each.value.sku

  tags = merge(local.tags, each.value.tags)
}

variable "container_registries" {
  type = map(object({
    name               = string
    resource_group_key = string
    admin_enabled      = bool

    sku = string

    tags = optional(map(string), {})
  }))
}
