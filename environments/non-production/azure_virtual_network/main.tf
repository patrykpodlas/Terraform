module "azure_virtual_network" {
  source                      = "../../../modules/azure_virtual_network"
  virtual_network_name        = "vnet-example"
  network_security_group_name = "nsg-example"
  subnet_name                 = "snet-example"
  resource_group_location     = "UK South"
  resource_group_name         = "rg-vnet"
  address_space               = ["10.0.0.0/16"]
  address_prefix              = "10.0.1.0/24"
  dns_servers                 = ["10.0.0.4", "10.0.0.5"]
}

output "outputs" {
  value = module.azure_virtual_network
}
