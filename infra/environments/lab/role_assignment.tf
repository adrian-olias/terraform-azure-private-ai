# What a role can be scoped to, and who can receive it, by type and key
locals {
  role_assignment_scopes = {
    storage_account    = { for key, m in module.storage_account : key => m.id }
    key_vault          = { for key, m in module.key_vault : key => m.id }
    container_registry = { for key, m in module.container_registry : key => m.id }
  }

  role_assignment_principals = {
    linux_vm    = { for key, m in module.linux_vm : key => m.principal_id }
    github_oidc = { for key, m in module.github_oidc : key => m.principal_id }
  }
}

module "role_assignment" {
  source   = "../../modules/role_assignment"
  for_each = var.role_assignments

  scope                = local.role_assignment_scopes[each.value.scope_type][each.value.scope_key]
  role_definition_name = each.value.role_definition_name
  principal_id         = local.role_assignment_principals[each.value.principal_type][each.value.principal_key]
}

variable "role_assignments" {
  type = map(object({
    scope_type           = string
    scope_key            = string
    role_definition_name = string
    principal_type       = string
    principal_key        = string
  }))
}
