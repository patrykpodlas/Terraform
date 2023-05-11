
data "vsphere_datacenter" "datacenter" {
  name = var.vsphere_datacenter
}

data "vsphere_compute_cluster" "cluster" {
  name          = var.vsphere_cluster
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_network" "network" {
  name          = var.vsphere_network
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_resource_pool" "pool" {
  name          = format("%s%s", data.vsphere_compute_cluster.cluster.name, "/Resources")
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_datastore" "datastore" {
  name          = var.vsphere_datastore
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_content_library" "content_library" {
  name = var.vsphere_content_library
}

data "vsphere_content_library_item" "content_library_item" {
  name       = var.vsphere_content_library_ovf
  type       = "ovf"
  library_id = data.vsphere_content_library.content_library.id
}

// Key Vault secrets

data "azurerm_key_vault" "hashicorp-key-vault" {
  name                = var.hashicorp_key_vault_name //variables.tf //key vault name
  resource_group_name = var.hashicorp_key_vault_rg   //variables.tf //resource group where the key vault resides
}

data "azurerm_key_vault_secret" "env_terra_vcenter_username" {
  depends_on = [
    data.azurerm_key_vault.hashicorp-key-vault
  ]
  name         = var.hashicorp_key_vault_secret_env_terra_da_username //variables.tf //azure key vault secret name
  key_vault_id = data.azurerm_key_vault.hashicorp-key-vault.id
}

data "azurerm_key_vault_secret" "env_terra_vcenter_password" {
  depends_on = [
    data.azurerm_key_vault.hashicorp-key-vault
  ]
  name         = var.hashicorp_key_vault_secret_env_terra_vcenter_password //variables.tf //azure key vault secret name
  key_vault_id = data.azurerm_key_vault.hashicorp-key-vault.id
}

data "azurerm_key_vault_secret" "env_terra_da_username" {
  depends_on = [
    data.azurerm_key_vault.hashicorp-key-vault
  ]
  name         = var.hashicorp_key_vault_secret_env_terra_da_username //variables.tf //azure key vault secret name
  key_vault_id = data.azurerm_key_vault.hashicorp-key-vault.id
}

data "azurerm_key_vault_secret" "env_terra_da_password" {
  depends_on = [
    data.azurerm_key_vault.hashicorp-key-vault
  ]
  name         = var.hashicorp_key_vault_secret_env_terra_da_password //variables.tf //azure key vault secret name
  key_vault_id = data.azurerm_key_vault.hashicorp-key-vault.id
}

data "azurerm_key_vault_secret" "env_terra_communicator_username" {
  depends_on = [
    data.azurerm_key_vault.hashicorp-key-vault
  ]
  name         = var.hashicorp_key_vault_secret_env_terra_communicator_username //variables.tf //azure key vault secret name
  key_vault_id = data.azurerm_key_vault.hashicorp-key-vault.id
}

data "azurerm_key_vault_secret" "env_terra_communicator_password" {
  depends_on = [
    data.azurerm_key_vault.hashicorp-key-vault
  ]
  name         = var.hashicorp_key_vault_secret_env_terra_communicator_password //variables.tf //azure key vault secret name
  key_vault_id = data.azurerm_key_vault.hashicorp-key-vault.id
}
