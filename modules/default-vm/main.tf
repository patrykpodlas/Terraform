resource "vsphere_virtual_machine" "default-vm" {
  count                   = 1
  name                    = var.vm_computer_name
  tags                    = var.default_tags
  folder                  = var.vsphere_folder
  num_cpus                = var.vm_cpus
  num_cores_per_socket    = var.vm_num_cores_per_socket
  memory                  = var.vm_memory
  firmware                = var.vm_firmware
  efi_secure_boot_enabled = var.vm_efi_secure_boot_enabled
  datastore_id            = data.vsphere_datastore.datastore.id
  resource_pool_id        = data.vsphere_resource_pool.pool.id
  annotation              = local.vm_annotation

  wait_for_guest_net_routable = false
  wait_for_guest_net_timeout  = 0


  network_interface {
    network_id = data.vsphere_network.network.id
  }
  disk {
    label            = "disk0"
    size             = var.vm_disk_size
    thin_provisioned = true
  }
  clone {
    template_uuid = data.vsphere_content_library_item.content_library_item.id
    customize {
      windows_options {
        run_once_command_list = [
          ""
        ]
        computer_name         = var.vm_computer_name
        admin_password        = data.azurerm_key_vault_secret.env_terra_communicator_password.value
        join_domain           = var.vm_domain
        domain_admin_user     = data.azurerm_key_vault_secret.env_terra_da_username.value
        domain_admin_password = data.azurerm_key_vault_secret.env_terra_da_password.value
        organization_name     = var.organization_name
        auto_logon_count      = 1
      }
      network_interface {
        ipv4_address = var.vm_ipv4_address
        ipv4_netmask = var.vm_ipv4_netmask
      }
      ipv4_gateway    = var.vm_ipv4_gateway
      dns_suffix_list = var.vm_dns_suffix_list
      dns_server_list = var.vm_dns_server_list
    }
  }
}
