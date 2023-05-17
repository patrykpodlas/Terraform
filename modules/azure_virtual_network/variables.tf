variable "virtual_network_name" {
  type = string
  validation {
    condition     = can(regex("^vnet-*", var.virtual_network_name))
    error_message = "The virtual network name must start with 'vnet-'"

  }
}

variable "network_security_group_name" {
  type = string
  validation {
    condition     = can(regex("^nsg-*", var.network_security_group_name))
    error_message = "The network security group name must start with 'nsg-'"

  }
}

variable "subnet_name" {
  type = string
  validation {
    condition     = can(regex("^snet-*", var.subnet_name))
    error_message = "The subnet name must start with 'snet-'"

  }
}

variable "resource_group_name" {
  type = string
}

variable "resource_group_location" {
  type = string
}
