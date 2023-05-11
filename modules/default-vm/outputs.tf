output "vm_computer_name" {
  value = var.vm_computer_name
}

output "vm_ipv4_address" {
  value = var.vm_ipv4_address
}

output "environment" {
  value = terraform.workspace
}
