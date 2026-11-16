# Identity for GitHub Actions. OIDC federation: GitHub exchanges its own token, no client secret exists.

# Fixed values defined by GitHub and Entra ID, not settings
locals {
  github_issuer   = "https://token.actions.githubusercontent.com"
  entra_audiences = ["api://AzureADTokenExchange"]

  owner = split("/", var.repository)[0]
  repo  = split("/", var.repository)[1]
}

resource "azuread_application" "this" {
  display_name = var.name
  owners       = var.owners
}

resource "azuread_service_principal" "this" {
  client_id = azuread_application.this.client_id
  owners    = var.owners
}

# One credential per workflow context allowed to log in, e.g. "pull_request" or "environment:Production".
# Only this repository can use them.
resource "azuread_application_federated_identity_credential" "this" {
  for_each = var.subjects

  application_id = azuread_application.this.id
  display_name   = "github-${each.key}"
  issuer         = local.github_issuer
  # GitHub's token carries the owner and repository IDs, not only their names
  subject   = "repo:${local.owner}@${var.owner_id}/${local.repo}@${var.repository_id}:${each.value}"
  audiences = local.entra_audiences
}
