# Introduction
A simple example of using Terraform with custom modules, using vSphere provider.

# Requirements
## Azure Key Vault
The variables for all the secrets are retrieves from Azure Key Vault using the azure-rm provider. Name of the secrets are in modules/`<module-name>`/variables.tf, you can remove them and remove the data sources if you wish to use plain text format, however creating a key vault and secrets is free.

You must provide the Azure Subscription ID and Tenant ID in providers section under modules/`<module-name>`/providers.tf
``` hcl
provider "azurerm" {
  features {}
  subscription_id = ""
  tenant_id       = ""
}
```
You can set-up the key vault using the azure-key-vault module in modules/azure-key-vault.
1. Switch directory to `environments/non-production/project-01`
2. In the `main.tf` file, change the `module name`, `rg_name`, and `key_vault_name`.
3. Execute

``` hcl
terraform init
terraform plan
terraform apply -auto-approve
```

## Variables
At bare minimum you must edit the modules/`<module-name>`/providers.tf with the detail about your vSphere environment and the vm_ variables:

`default_vsphere_server`

`vsphere_datacenter`

`vsphere_cluster`

`vsphere_datastore`

`vsphere_content_library`

`vsphere_content_library_ovf`

# Modules
A module is a container of code for multiple resources that are used together. Currently the modules are almost the same with slight variations such as the number of disks, CPU's, memory etc.
## How to use
1. Modify the variables in modules/`<module-name>`/variables.tf in each of the module paths.
2. Create folder inside projects directory for your new application or service, name it after the application or service.
3. Switch to the new directory.
4. Copy the `template/project-1` contents.
5. Modify the amount of VM's to be deployed by duplicating the blocks of code, the module name is the name of the deployed resource Terraform will keep track of, the source is the module to be used.

Example 1
``` hcl
module "sql-001-p-p" {
  source                      = "../../../modules/sql-vm"
  vm_computer_name            = "sql-001-p-p"
  vm_ipv4_address             = "192.168.1.221"
  vm_ipv4_gateway             = "192.168.1.1"
  vm_cpus                     = 1
  vsphere_folder              = "Terraform Built/Production"
  vsphere_content_library_ovf = "windows-server-2019-std-dexp"
}

module "vm-001-p-p" {
  source                      = "../../../modules/default-vm"
  vm_computer_name            = "vm-001-p-p"
  vm_ipv4_address             = "192.168.1.222"
  vm_ipv4_gateway             = "192.168.1.1"
  vm_cpus                     = 1
  vsphere_folder              = "Terraform Built/Production"
  vsphere_content_library_ovf = "windows-server-2019-std-dexp"
}
```
6. Execute
``` hcl
terraform init
terraform plan
terraform apply -auto-approve
```