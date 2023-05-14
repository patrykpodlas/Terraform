module "test-vm" {
  source                      = "../../../modules/default-vm"
  vm_computer_name            = "test-vm"
  vm_ipv4_address             = "192.168.1.224"
  vm_ipv4_gateway             = "192.168.1.1"
  vm_cpus                     = 1
  vsphere_folder              = "Terraform Built/Non-Production"
  vsphere_content_library_ovf = "windows-server-2019-std-dexp"
}
