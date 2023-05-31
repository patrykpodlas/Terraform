output "key_vault_name" {
  value       = azurerm_key_vault.generic-kv.name
  description = ""
}

output "key_vault_rg_name" {
  value       = azurerm_key_vault.generic-kv.resource_group_name
  description = ""
}