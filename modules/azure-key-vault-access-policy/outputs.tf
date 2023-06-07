output "key_vault_name" {
  value       = azurerm_key_vault.key_vault_access_policy.name
  description = ""
}

output "key_vault_resource_group_name" {
  value       = azurerm_key_vault.key_vault_access_policy.resource_group_name
  description = ""
}
