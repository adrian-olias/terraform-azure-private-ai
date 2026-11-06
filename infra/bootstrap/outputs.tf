output "storage_account_name" {
  description = "State storage account, passed to `terraform init` in each environment."
  value       = azurerm_storage_account.tfstate.name
}
