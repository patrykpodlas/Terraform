module "vm-001-n-el" {
  source                      = "../../modules/default-vm"
  vm_computer_name            = ""
  vm_ipv4_address             = "1"
  vm_ipv4_gateway             = ""
  vm_cpus                     = 1
  vsphere_folder              = "Terraform Built/Non-Production"
  vsphere_content_library_ovf = "windows-server-2019-std-dexp"
}
