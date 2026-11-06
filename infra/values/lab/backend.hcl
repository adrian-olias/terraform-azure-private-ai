# Backend values for infra/environments/lab. Passed with -backend-config at init (see README).
# storage_account_name is passed on the command line, because bootstrap creates it with a random suffix.
resource_group_name = "rg-privateai-tfstate"
container_name      = "tfstate"
key                 = "lab.tfstate"
use_azuread_auth    = true
