module "subnet_network_security_group_association" {
  source   = "../../modules/subnet_network_security_group_association"
  for_each = var.subnet_network_security_group_associations

  subnet_id                 = module.subnet[each.value.subnet_key].id
  network_security_group_id = module.network_security_group[each.value.network_security_group_key].id
}

variable "subnet_network_security_group_associations" {
  type = map(object({
    subnet_key                 = string
    network_security_group_key = string
  }))
}
