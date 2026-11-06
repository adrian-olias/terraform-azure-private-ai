# Associations have no name in Azure, so the key is the subnet they protect
subnet_network_security_group_associations = {
  snet-compute = {
    subnet_key                 = "snet-compute"
    network_security_group_key = "nsg-compute"
  }

  snet-endpoints = {
    subnet_key                 = "snet-endpoints"
    network_security_group_key = "nsg-endpoints"
  }
}
