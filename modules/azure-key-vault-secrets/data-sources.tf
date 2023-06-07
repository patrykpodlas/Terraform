data "azurerm_client_config" "current" {}

data "azurerm_key_vault" "name" {
  name                = var.key_vault_name
  resource_group_name = var.key_vault_resource_group_name
}
