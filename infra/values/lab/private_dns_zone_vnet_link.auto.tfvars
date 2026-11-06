private_dns_zone_vnet_links = {
  link-vnet-privateai-lab-blob = {
    name                 = "link-vnet-privateai-lab-blob"
    private_dns_zone_key = "privatelink.blob.core.windows.net"
    virtual_network_key  = "vnet-privateai-lab"
    registration_enabled = false
  }

  link-vnet-privateai-lab-vault = {
    name                 = "link-vnet-privateai-lab-vault"
    private_dns_zone_key = "privatelink.vaultcore.azure.net"
    virtual_network_key  = "vnet-privateai-lab"
    registration_enabled = false
  }
}
