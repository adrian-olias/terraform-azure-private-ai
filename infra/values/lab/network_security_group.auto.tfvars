network_security_groups = {
  # No inbound rules: nothing reaches the VM
  nsg-vm-lab-spc-001 = {
    name                      = "nsg-vm-lab-spc-001"
    resource_group_key        = "rg-privateai-lab"
    deny_all_inbound_priority = 4096
    inbound_rules             = {}
  }

  # Only HTTPS from the compute subnet
  nsg-pe-lab-spc-001 = {
    name                      = "nsg-pe-lab-spc-001"
    resource_group_key        = "rg-privateai-lab"
    deny_all_inbound_priority = 4096
    inbound_rules = {
      AllowComputeHttps = {
        name                       = "AllowComputeHttps"
        priority                   = 100
        protocol                   = "Tcp"
        source_port_range          = "*"
        source_subnet_key          = "snet-vm-lab-spc-001"
        destination_address_prefix = "*"
        destination_port_range     = "443"
      }
    }
  }
}
