module "storage_container" {
  source   = "../../modules/storage_container"
  for_each = var.storage_containers

  name = each.value.name

  storage_account_id    = module.storage_account[each.value.storage_account_key].id
  container_access_type = each.value.container_access_type

}

variable "storage_containers" {
  type = map(object({
    name                  = string
    storage_account_key   = string
    container_access_type = string

  }))
}
