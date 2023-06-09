# Introduction
A simple example of using Terraform with custom modules, using vSphere, and Azure providers.
# Directory structure
```
├─ .gitignore
├─ README.md
├─ environments
│  ├─ non-production
│  │  ├─ azure_ad_users
│  │  │  ├─ .terraform.lock.hcl
│  │  │  └─ main.tf
│  │  ├─ key_vault_for_terraform
│  │  │  ├─ .terraform.lock.hcl
│  │  │  ├─ main.tf
│  │  │  ├─ outputs.tf
│  │  │  └─ variables.tf
│  │  ├─ test-vm
│  │  │  ├─ .terraform.lock.hcl
│  │  │  ├─ main.tf
│  │  │  ├─ outputs.tf
│  │  │  └─ variables.tf
│  │  └─ vm-image-builder
│  │     ├─ .terraform.lock.hcl
│  │     └─ main.tf
│  └─ production
│     └─ project-1
│        ├─ .terraform.lock.hcl
│        ├─ main.tf
│        ├─ outputs.tf
│        └─ variables.tf
├─ modules
│  ├─ azure-ad-users
│  │  ├─ main.tf
│  │  ├─ outputs.tf
│  │  ├─ providers.tf
│  │  └─ variables.tf
│  ├─ azure-key-vault-secrets
│  │  ├─ data-sources.tf
│  │  ├─ main.tf
│  │  ├─ providers.tf
│  │  └─ variables.tf
│  ├─ azure-key-vault
│  │  ├─ data-sources.tf
│  │  ├─ main.tf
│  │  ├─ outputs.tf
│  │  ├─ providers.tf
│  │  └─ variables.tf
│  ├─ azure-vm-image-builder
│  │  ├─ data-sources.tf
│  │  ├─ main.tf
│  │  ├─ providers.tf
│  │  └─ variables.tf
│  ├─ default-vm
│  │  ├─ data-sources.tf
│  │  ├─ locals.tf
│  │  ├─ main.tf
│  │  ├─ outputs.tf
│  │  ├─ providers.tf
│  │  └─ variables.tf
│  └─ sql-vm
│     ├─ data-sources.tf
│     ├─ locals.tf
│     ├─ main.tf
│     ├─ outputs.tf
│     ├─ providers.tf
│     └─ variables.tf
└─ template
   ├─ module
   │  ├─ main.tf
   │  ├─ outputs.tf
   │  ├─ providers.tf
   │  └─ variables.tf
   └─ project-1
      ├─ main.tf
      ├─ outputs.tf
      └─ variables.tf
```
# Modules
A module is a container of Terraform code for single or multiple resources grouped together, used as means to prevent code duplication in projects.

Sourcing the module is as simple as:
``` hcl
module "<to-be-deployed-resource-name>" {
    source = "<path-to-the-module>"
    parameter1 = value1
    parameter2 = value2
}
```

In this case, the so called root module is the above, whilst the child module, is the module being sourced.
## default-vm / sql-vm
### Requirements
#### Azure Key Vault
The variables for all the secrets are retrieved from Azure Key Vault using the azure-rm provider. Name of the secrets are in modules/`<module-name>`/variables.tf, you can remove them and remove the data sources if you wish to use plain text format, however creating a key vault and secrets is free.

You must provide the Azure Subscription ID and Tenant ID in providers section under modules/`<module-name>`/providers.tf
``` hcl
provider "azurerm" {
  features {}
  subscription_id = ""
  tenant_id       = ""
}
```
You can set-up the key vault and the necessary secrets using the azure-key-vault module in `modules/azure-key-vault` and `modules/azure-key-vault-secrets`.
1. Switch directory to `environments/non-production/key_vault_for_terraform`.
2. In the `main.tf` file, change the:

    `module name`

    `rg_name`

    `key_vault_name`

3. Update all of the `secret_value` variables to match your environment.
4. Execute.

``` hcl
terraform init
terraform plan
terraform apply -auto-approve
```
#### Variables
At bare minimum you must edit the modules/`<module-name>`/providers.tf with the detail about your vSphere environment and the vm_ variables:

`default_vsphere_server`

`vsphere_datacenter`

`vsphere_cluster`

`vsphere_datastore`

`vsphere_content_library`

`vsphere_content_library_ovf`

### How to use
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
## Azure VM Image Builder
This module builds an entire Azure VM Image Builder environment.
### Requirements
Azure subscription.
### How to use
1. For simplicity, switch directory to `./environments/non-production/vm-image-builder`.
2. Execute
``` hcl
terraform init
terraform plan
terraform apply -auto-approve
```