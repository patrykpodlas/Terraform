module "avib_environment" {
  source                    = "../../../modules/azure-vm-image-builder"
  Location                  = "uksouth"
  ImageResourceGroup        = "rg-vmimagebuilder"
  StagingImageResourceGroup = "rg-vmimagebuilder-staging"
  vNetResourceGroup         = "rg-vmimagebuilder"
  GalleryName               = "cgvmibimages"
  ImageDefinitionName       = "windows_11_gen2_generic"
  VMGeneration              = "V2"
  ImageRoleDefinitionName   = "Azure Image Builder Image Creation Definition"
  NetworkRoleDefinitionName = "Azure Image Builder Network Join Definition"
  IdentityName              = "umi-vmimagebuilder"
  vNETName                  = "vnet-vmimagebuilder"
  SubnetName                = "vnet-snet-vmimagebuilder"
  NSGName                   = "nsg-snet-vmimagebuilder"
  CompanyName               = "MyCompany"
  RunOutputName             = "windows_11_gen2_generic"
}
