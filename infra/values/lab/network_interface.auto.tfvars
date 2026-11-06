network_interfaces = {
  nic-privateai-lab-vm = {
    name               = "nic-privateai-lab-vm"
    resource_group_key = "rg-privateai-lab"
    subnet_key         = "snet-compute"
    private_ip_address = "10.1.1.10" # static, so the address is known. Use null for a dynamic IP
  }
}
