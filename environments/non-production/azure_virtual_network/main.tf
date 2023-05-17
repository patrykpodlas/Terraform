module "azure_virtual_network" {
  source                      = "../../../modules/azure_virtual_network"
  virtual_network_name        = "vnet-example"
  network_security_group_name = "nsg-example"
  subnet_name                 = "snet-example"
  resource_group_location     = "UK South"
  resource_group_name         = "rg-vnet"
}
