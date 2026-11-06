# Identity for GitHub Actions. OIDC federation: GitHub exchanges its own token, no client secret exists.

# Fixed values defined by GitHub and Entra ID, not settings
locals {
  github_issuer   = "https://token.actions.githubusercontent.com"
  entra_audiences = ["api://AzureADTokenExchange"]
}

resource "azuread_application" "this" {
  display_name = var.name
  owners       = var.owners
}

resource "azuread_service_principal" "this" {
  client_id = azuread_application.this.client_id
  owners    = var.owners
}

# Only workflows running on this repository and branch can log in
resource "azuread_application_federated_identity_credential" "this" {
  application_id = azuread_application.this.id
  display_name   = "github-${var.branch}"
  issuer         = local.github_issuer
  subject        = "repo:${var.repository}:ref:refs/heads/${var.branch}"
  audiences      = local.entra_audiences
}
