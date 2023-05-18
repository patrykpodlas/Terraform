output "virtual_network_name" {
  value = azurerm_virtual_network.virtual_network.name
}

output "address_space" {
  value = azurerm_virtual_network.virtual_network.address_space
}

output "dns_servers" {
  value = azurerm_virtual_network.virtual_network.dns_servers
}

output "subnet_name" {
  value = azurerm_virtual_network.virtual_network.subnet[*].name
}

