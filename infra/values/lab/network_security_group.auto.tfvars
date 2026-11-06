network_security_groups = {
  # No inbound rules: nothing reaches the VM
  nsg-compute = {
    name                      = "nsg-compute"
    resource_group_key        = "rg-privateai-lab"
    deny_all_inbound_priority = 4096
    inbound_rules             = {}
  }

  # Only HTTPS from the compute subnet
  nsg-endpoints = {
    name                      = "nsg-endpoints"
    resource_group_key        = "rg-privateai-lab"
    deny_all_inbound_priority = 4096
    inbound_rules = {
      AllowComputeHttps = {
        name                       = "AllowComputeHttps"
        priority                   = 100
        protocol                   = "Tcp"
        source_port_range          = "*"
        source_subnet_key          = "snet-compute"
        destination_address_prefix = "*"
        destination_port_range     = "443"
      }
    }
  }
}
