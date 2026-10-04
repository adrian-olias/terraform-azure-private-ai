###############################################################################
#  MODULE environment_group — RBAC: VM → Storage Blob Data Reader
###############################################################################

resource "azurerm_role_assignment" "vm_blob_reader" {
  scope                = azurerm_storage_account.main.id
  role_definition_name = "Storage Blob Data Reader"
  principal_id         = azurerm_linux_virtual_machine.ai_engine.identity[0].principal_id

  depends_on = [
    azurerm_linux_virtual_machine.ai_engine
  ]
}
