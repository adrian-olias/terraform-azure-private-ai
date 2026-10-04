###############################################################################
#  MODULE environment_group — Resource Group + Data Sources
###############################################################################

# ─── Resource Group ───────────────────────────────────────────────────────────

resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

# ─── Data Sources ─────────────────────────────────────────────────────────────

data "azurerm_subscription" "current" {}
