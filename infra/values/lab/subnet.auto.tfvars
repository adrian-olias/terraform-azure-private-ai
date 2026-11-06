subnets = {
  # The VM. Temporary egress for apt, Docker and NVIDIA. Production: NAT Gateway
  snet-compute = {
    name                              = "snet-compute"
    virtual_network_key               = "vnet-privateai-lab"
    address_prefix                    = "10.1.1.0/24"
    default_outbound_access_enabled   = true
    private_endpoint_network_policies = "Enabled"
  }

  # Private endpoints for Storage and Key Vault
  snet-endpoints = {
    name                              = "snet-endpoints"
    virtual_network_key               = "vnet-privateai-lab"
    address_prefix                    = "10.1.2.0/24"
    default_outbound_access_enabled   = false
    private_endpoint_network_policies = "Enabled"
  }
}
