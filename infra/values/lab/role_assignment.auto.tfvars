# Role assignments have no name in Azure, so the key describes who gets which role where.
# Least privilege: the VM gets one read role per service, nothing broader.
role_assignments = {
  vm-privateai-lab-storage-blob-data-reader = {
    scope_type           = "storage_account"
    scope_key            = "stprivateailab"
    role_definition_name = "Storage Blob Data Reader"
    principal_type       = "linux_vm"
    principal_key        = "vm-privateai-lab"
  }

  vm-privateai-lab-key-vault-secrets-user = {
    scope_type           = "key_vault"
    scope_key            = "kv-privateai-lab"
    role_definition_name = "Key Vault Secrets User"
    principal_type       = "linux_vm"
    principal_key        = "vm-privateai-lab"
  }

  vm-privateai-lab-acr-pull = {
    scope_type           = "container_registry"
    scope_key            = "crprivateailab"
    role_definition_name = "AcrPull"
    principal_type       = "linux_vm"
    principal_key        = "vm-privateai-lab"
  }

  # GitHub Actions pushes images to the registry
  app-privateai-lab-github-acr-push = {
    scope_type           = "container_registry"
    scope_key            = "crprivateailab"
    role_definition_name = "AcrPush"
    principal_type       = "github_oidc"
    principal_key        = "app-privateai-lab-github"
  }

  # GitHub Actions deploys with az vm run-command, through Azure's control plane: no inbound, no agent
  app-privateai-lab-github-vm-contributor = {
    scope_type           = "linux_vm"
    scope_key            = "vm-privateai-lab"
    role_definition_name = "Virtual Machine Contributor"
    principal_type       = "github_oidc"
    principal_key        = "app-privateai-lab-github"
  }

  # The operator writes what the VM reads: documents in Storage, secrets in Key Vault
  operator-storage-blob-data-contributor = {
    scope_type           = "storage_account"
    scope_key            = "stprivateailab"
    role_definition_name = "Storage Blob Data Contributor"
    principal_type       = "operator"
    principal_key        = "current"
  }

  operator-key-vault-secrets-officer = {
    scope_type           = "key_vault"
    scope_key            = "kv-privateai-lab"
    role_definition_name = "Key Vault Secrets Officer"
    principal_type       = "operator"
    principal_key        = "current"
  }
}
