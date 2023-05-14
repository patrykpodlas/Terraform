data "azurerm_subscription" "primary" {
}

data "azurerm_client_config" "example" {
}

data "azuread_service_principal" "avib" {
  display_name = "Azure Virtual Machine Image Builder"
}
