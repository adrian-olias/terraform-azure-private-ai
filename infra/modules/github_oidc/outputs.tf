output "client_id" {
  description = "Application (client) ID, used as AZURE_CLIENT_ID in GitHub."
  value       = azuread_application.this.client_id
}

output "principal_id" {
  description = "Service principal object ID, for role assignments."
  value       = azuread_service_principal.this.object_id
}
