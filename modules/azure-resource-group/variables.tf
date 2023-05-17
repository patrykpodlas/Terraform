variable "resource_group_name" {
  type = string
  validation {
    condition     = can(regex("^rg-*", var.resource_group_name))
    error_message = "The resource group name must start with 'rg-'"
  }
}

variable "resource_group_location" {
  type = string
  validation {
    condition     = var.resource_group_location == "UK South"
    error_message = "Only the UK South region is supported."

  }
}
