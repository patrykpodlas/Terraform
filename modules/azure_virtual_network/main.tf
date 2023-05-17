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
  resource_group_name = azurerm_network_security_group.network_security_group.name
  location            = azurerm_network_security_group.network_security_group.location
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  subnet {
    name           = var.subnet_name
    address_prefix = "10.0.1.0/24"
    security_group = azurerm_network_security_group.network_security_group.id
  }

  tags = {
    environment = "Production"
  }
}

