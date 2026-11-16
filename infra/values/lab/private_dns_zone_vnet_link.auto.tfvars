private_dns_zone_vnet_links = {
  link-vnet-privateai-lab-spc-001-blob = {
    name                 = "link-vnet-privateai-lab-spc-001-blob"
    private_dns_zone_key = "privatelink.blob.core.windows.net"
    virtual_network_key  = "vnet-privateai-lab-spc-001"
    registration_enabled = false
  }

  link-vnet-privateai-lab-spc-001-vault = {
    name                 = "link-vnet-privateai-lab-spc-001-vault"
    private_dns_zone_key = "privatelink.vaultcore.azure.net"
    virtual_network_key  = "vnet-privateai-lab-spc-001"
    registration_enabled = false
  }
}
