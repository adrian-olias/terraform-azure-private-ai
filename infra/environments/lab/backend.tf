# Remote state for this environment. The state storage is created by infra/bootstrap, which
# gives its account a random suffix: paste the storage_account_name output below, then `terraform init`.
terraform {
  backend "azurerm" {
    resource_group_name  = "rg-privateai-tfstate"
    storage_account_name = "REPLACE-ME"
    container_name       = "tfstate"
    key                  = "lab.tfstate"
    use_azuread_auth     = true
  }
}
