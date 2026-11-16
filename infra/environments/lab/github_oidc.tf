# GitHub's numeric IDs, read at plan time. GitHub puts them in the token subject
data "github_user" "owner" {
  for_each = var.github_oidcs

  username = split("/", each.value.repository)[0]
}

data "github_repository" "this" {
  for_each = var.github_oidcs

  full_name = each.value.repository
}

module "github_oidc" {
  source   = "../../modules/github_oidc"
  for_each = var.github_oidcs

  name          = each.value.name
  repository    = each.value.repository
  owner_id      = data.github_user.owner[each.key].id
  repository_id = data.github_repository.this[each.key].repo_id
  subjects      = each.value.subjects
  owners        = [data.azurerm_client_config.current.object_id]
}

variable "github_oidcs" {
  type = map(object({
    name       = string
    repository = string
    subjects   = map(string)
  }))
}
