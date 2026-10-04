###############################################################################
#  BOOTSTRAP — Azure Provider
#  Executes with LOCAL state (run once) to create the Storage Account
#  that will hold the remote Terraform state.
#
#  The subscription_id is read from the ARM_SUBSCRIPTION_ID environment variable
#  (Terraform AzureRM standard). Configure it before running:
#
#    export ARM_SUBSCRIPTION_ID="<your-subscription-id>"
#  or:
#    az account set --subscription "<name-or-id>"
###############################################################################

terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.49.0"
    }
  }
}

provider "azurerm" {
  features {}
  # subscription_id is read automatically from ARM_SUBSCRIPTION_ID
  # or from the active Azure CLI context (az login / az account set)
}
