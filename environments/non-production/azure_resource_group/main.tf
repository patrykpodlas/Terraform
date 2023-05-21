module "azure_resource_group" {
  source                        = "../../../modules/azure-resource-group"
  azure_resource_group_name     = "rg-azure-resource-group"
  azure_resource_group_location = "UK South"
}

