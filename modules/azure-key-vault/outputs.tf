output "key-vault-name" {
  value       = azurerm_key_vault.generic-kv.name
  description = ""
}

output "rg-name" {
  value       = azurerm_resource_group.generic-rg.name
  description = ""
}
