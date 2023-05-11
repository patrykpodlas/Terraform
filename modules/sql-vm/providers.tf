provider "azurerm" {
  features {}
  subscription_id = ""
  tenant_id       = ""
}

provider "vsphere" {
  //credentials to login to vSphere
  vsphere_server       = var.default_vsphere_server                                     //variables.tf
  user                 = data.azurerm_key_vault_secret.env_terra_vcenter_username.value //variables.tf
  password             = data.azurerm_key_vault_secret.env_terra_vcenter_password.value //data-sources.tf
  allow_unverified_ssl = var.default_vsphere_insecure                                   //variables.tf
}
