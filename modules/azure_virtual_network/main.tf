module "resource_group" {
  source                  = "../azure-resource-group"
  resource_group_name     = var.resource_group_name
  resource_group_location = var.resource_group_location
}

resource "azurerm_network_security_group" "network_security_group" {
  name                = var.network_security_group_name
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
}

resource "azurerm_virtual_network" "virtual_network" {
  name                = var.virtual_network_name
  resource_group_name = azurerm_network_security_group.network_security_group.resource_group_name
  location            = azurerm_network_security_group.network_security_group.location
  address_space       = var.address_space
  dns_servers         = var.dns_servers

  subnet {
    name           = var.subnet_name
    address_prefix = var.address_prefix
    security_group = azurerm_network_security_group.network_security_group.id
  }

  tags = {
    environment = "Production"
  }
}

