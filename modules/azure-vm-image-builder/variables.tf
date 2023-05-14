# variables.tf

variable "Location" {
  description = "Azure region."
}

variable "ImageResourceGroup" {
  description = "Resource group which will contain all the permanent resources."
}

variable "StagingImageResourceGroup" {
  description = "Resource group which will contain all the temporary resources created by the Azure VM Image Builder service."
}

variable "vNetResourceGroup" {
  description = "Resource group which will contain the networking components to be used by Azure VM Image Builder service."
}

variable "GalleryName" {
  description = "Azure Compute Gallery name."
}

variable "ImageDefinitionName" {
  description = "Azure Compute Gallery image definition name."
}

variable "VMGeneration" {
  description = "Virtual Machine generation."
}

variable "ImageRoleDefinitionName" {
  description = "Name of the role definition for Image Creation."
}

variable "NetworkRoleDefinitionName" {
  description = "Name of the role definition for Network Join."
}

variable "IdentityName" {
  description = "User Managed Identity name."
}

variable "vNETName" {
  description = "Virtual Network name."
}

variable "SubnetName" {
  description = "Subnet name."
}

variable "NSGName" {
  description = "Network Security Group name."
}

variable "CompanyName" {
  description = "Company name."
}

variable "RunOutputName" {
  description = "Run output name."
}
