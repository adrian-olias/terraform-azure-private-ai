module "resource_group" {
  source   = "../../modules/resource_group"
  for_each = var.resource_groups

  name     = each.value.name
  location = var.location
  tags     = merge(local.tags, each.value.tags)
}

variable "resource_groups" {
  type = map(object({
    name = string
    tags = optional(map(string), {})
  }))
}
