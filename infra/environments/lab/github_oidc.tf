module "github_oidc" {
  source   = "../../modules/github_oidc"
  for_each = var.github_oidcs

  name       = each.value.name
  repository = each.value.repository
  branch     = each.value.branch
  owners     = [data.azurerm_client_config.current.object_id]
}

variable "github_oidcs" {
  type = map(object({
    name       = string
    repository = string
    branch     = string
  }))
}
