subnets = {
  # The VM. Temporary egress for apt, Docker and the model download. Production: NAT Gateway
  snet-vm-lab-spc-001 = {
    name                              = "snet-vm-lab-spc-001"
    virtual_network_key               = "vnet-privateai-lab-spc-001"
    address_prefix                    = "10.1.1.0/24"
    default_outbound_access_enabled   = true
    private_endpoint_network_policies = "Enabled"
  }

  # Private endpoints for Storage and Key Vault
  snet-pe-lab-spc-001 = {
    name                              = "snet-pe-lab-spc-001"
    virtual_network_key               = "vnet-privateai-lab-spc-001"
    address_prefix                    = "10.1.2.0/24"
    default_outbound_access_enabled   = false
    private_endpoint_network_policies = "Enabled"
  }
}
