# Associations have no name in Azure, so the key is the subnet they protect
subnet_network_security_group_associations = {
  snet-vm-lab-spc-001 = {
    subnet_key                 = "snet-vm-lab-spc-001"
    network_security_group_key = "nsg-vm-lab-spc-001"
  }

  snet-pe-lab-spc-001 = {
    subnet_key                 = "snet-pe-lab-spc-001"
    network_security_group_key = "nsg-pe-lab-spc-001"
  }
}
