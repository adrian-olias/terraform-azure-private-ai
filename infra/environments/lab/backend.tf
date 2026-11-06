# Remote state for this environment. Backend blocks cannot use variables, so the values come from
# values/lab/backend.hcl and from the CLI (the storage account name is created by bootstrap):
#   terraform init -backend-config=../../values/lab/backend.hcl -backend-config="storage_account_name=$STATE_SA"
terraform {
  backend "azurerm" {}
}
