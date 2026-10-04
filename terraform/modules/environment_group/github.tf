###############################################################################
#  MODULE environment_group — Service Principal for GitHub Actions
#
#  Creates an AAD App Registration + Service Principal with AcrPush rights,
#  so the CI/CD pipeline can build and push Docker images to ACR.
###############################################################################

# 1. Register Application (Bot) in Entra ID (Azure AD)
resource "azuread_application" "github_actions" {
  display_name = "sp-github-actions-${var.resource_group_name}"
}

# 2. Create Service Principal (physical identity) linked to the App
resource "azuread_service_principal" "github_actions" {
  client_id = azuread_application.github_actions.client_id
}

# 3. Generate a secret password for the Service Principal
resource "azuread_service_principal_password" "github_actions" {
  service_principal_id = azuread_service_principal.github_actions.id
}

# 4. Assign AcrPush role to the SP over the Container Registry
resource "azurerm_role_assignment" "github_acr_push" {
  scope                = azurerm_container_registry.main.id
  role_definition_name = "AcrPush"
  principal_id         = azuread_service_principal.github_actions.object_id
}
