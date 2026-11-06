output "resource_group_names" {
  value = { for key, m in module.resource_group : key => m.name }
}

output "vm_names" {
  value = { for key, m in module.linux_vm : key => m.name }
}

output "vm_private_ips" {
  value = { for key, m in module.network_interface : key => m.private_ip_address }
}

output "storage_account_names" {
  value = { for key, m in module.storage_account : key => m.name }
}

output "key_vault_names" {
  value = { for key, m in module.key_vault : key => m.name }
}

output "acr_login_servers" {
  value = { for key, m in module.container_registry : key => m.login_server }
}

# Repository variables for azure/login in GitHub Actions (none of them is a secret)
output "github_oidc" {
  value = {
    for key, m in module.github_oidc : key => {
      AZURE_CLIENT_ID       = m.client_id
      AZURE_TENANT_ID       = data.azurerm_client_config.current.tenant_id
      AZURE_SUBSCRIPTION_ID = data.azurerm_client_config.current.subscription_id
    }
  }
}
