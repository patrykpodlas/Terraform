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
