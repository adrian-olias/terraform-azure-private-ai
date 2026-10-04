###############################################################################
#  MANIFESTS — Provider de Azure + Remote Backend
#
#  The backend points to the Storage Account created by bootstrap/.
#  ⚠️ Run bootstrap FIRST before running terraform init here.
###############################################################################

terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.75.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.9.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "3.8.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "4.1.0"
    }
  }

  # ─── Remote Backend (Azure Storage) ────────────────────────────────────────
  # These values come from the bootstrap output.
  # Adjust storage_account_name if you changed it in bootstrap.
  backend "azurerm" {
    resource_group_name  = "rg-tf-bootstrap-001"
    storage_account_name = "stterraformstate001"
    container_name       = "tfstate"
    key                  = "lab.terraform.tfstate"
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
    key_vault {
      recover_soft_deleted_key_vaults = true
      purge_soft_delete_on_destroy    = false
    }
  }
  # subscription_id is read from ARM_SUBSCRIPTION_ID env var
  # or from the active Azure CLI context (az login / az account set)
}

provider "random" {
}

provider "azuread" {
}
