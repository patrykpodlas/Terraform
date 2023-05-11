// vsphere login settings

variable "default_vsphere_server" {
  description = "VCSA's FQDN to connect to."
  type        = string
  default     = "vcsa-001-p-p.podlas.local"
}

variable "default_vsphere_username" {
  description = "User with enouth privilages to connect to VCSA and build the VM, this user must be added in VCSA's permissions."
  type        = string
  default     = ""
  sensitive   = true
}

variable "default_vsphere_password" {
  description = "Password for the privilaged user above."
  type        = string
  default     = ""
  sensitive   = true
}

variable "default_vsphere_insecure" {
  description = "Allows to connect even with certificate error."
  type        = bool
  default     = true
}

// vsphere settings

variable "vsphere_datacenter" {
  description = "Datacenter in which the VM is going to be deployed in."
  type        = string
  default     = "Home"
}

variable "vsphere_cluster" {
  description = "Cluster in which the VM is going to be deployed in."
  type        = string
  default     = "WK-92-NP-LAB"
}

variable "vsphere_datastore" {
  description = "Datastore in which the VM is going to be deployed in."
  type        = string
  default     = "DS-LK-ESXI-001-HashiCorp-VM-NVME"
}

variable "vsphere_folder" {
  description = "Folder within vSphere where the VM will be placed, this folder is chosen depending on Workspace selected."
  type        = string
  default     = "Discovered virtual machine"
}

variable "vsphere_network" {
  description = "VM network within vSphere where the VM will be placed, the network should be different depending on what the servers does, for example the SQL server has a different network."
  type        = string
  default     = "VM Network"
}

variable "vsphere_content_library" {
  description = "Content library name where the template to clone resides."
  default     = "Packer Templates"
  type        = string
}

variable "vsphere_content_library_ovf" {
  description = "Name of the default template for VM deployment."
  default     = "windows-server-2019-std-core"
  type        = string
}

variable "default_tags" {
  description = "Default tag for the VM."
  default     = ["Terraform"]
  type        = list(string)
}

// virtual machine settings

variable "vm_computer_name" {
  description = "VM computer name (hostname)."
  type        = string
  default     = ""
}

variable "organization_name" {
  description = "Organization name"
  default     = "Podlas"
  type        = string
}

variable "vm_cpus" {
  description = "Number of CPUs the VM will have."
  type        = number
  default     = 1
}

variable "vm_num_cores_per_socket" {
  description = "Number of cores per CPU for the VM."
  default     = 1
  type        = number
}

variable "vm_memory" {
  description = "Amount of RAM the VM will have."
  default     = 2048
  type        = number
}

variable "vm_disk_size" {
  description = "Default size of the system disk for the VM, in GB."
  default     = 50
  type        = number
}

variable "vm_firmware" {
  type    = string
  default = "efi"
}

variable "vm_efi_secure_boot_enabled" {
  type    = bool
  default = true
}

variable "vm_domain" {
  description = "Domain the guest OS will join to."
  default     = "podlas.local"
  type        = string
}

variable "vm_ipv4_address" {
  description = "IPv4 address for the VM's primary network interface."
  type        = string
  default     = ""
}

variable "vm_ipv4_netmask" {
  description = "Default subnet mask."
  default     = "24"
  type        = string
}

variable "vm_ipv4_gateway" {
  type    = string
  default = ""
}

variable "vm_dns_suffix_list" {
  type    = list(string)
  default = ["podlas.local"]
}

variable "vm_dns_server_list" {
  type    = list(string)
  default = ["192.168.1.181"]
}

// key vault defaults
variable "hashicorp_key_vault_name" {
  description = "Name of the key vault."
  type        = string
  default     = "kv-ppodlas-hashicorp"
}

variable "hashicorp_key_vault_rg" {
  description = "Name of the resource group with the key vault."
  type        = string
  default     = "rg-hashicorp"
}

variable "hashicorp_key_vault_secret_env_terra_da_username" {
  description = "Name of the teraform secret in Azure Key Vault."
  type        = string
  default     = "env-terra-da-username"
}

variable "hashicorp_key_vault_secret_env_terra_da_password" {
  description = "Name of the teraform secret in Azure Key Vault."
  type        = string
  default     = "env-terra-da-password"
}

variable "hashicorp_key_vault_secret_env_terra_vcenter_username" {
  description = "Name of the teraform secret in Azure Key Vault."
  type        = string
  default     = "env-terra-vcenter-username"
}

variable "hashicorp_key_vault_secret_env_terra_vcenter_password" {
  description = "Name of the teraform secret in Azure Key Vault."
  type        = string
  default     = "env-terra-vcenter-password"
}

variable "hashicorp_key_vault_secret_env_terra_communicator_username" {
  description = "Name of the teraform secret in Azure Key Vault, this secret is the local administrator of the VM when it's built."
  type        = string
  default     = "env-terra-communicator-username"
}

variable "hashicorp_key_vault_secret_env_terra_communicator_password" {
  description = "Name of the teraform secret in Azure Key Vault, this secret is the local administrator of the VM when it's built."
  type        = string
  default     = "env-terra-communicator-password"
}
