terraform {
  required_providers {
    azuread = {
      source = "hashicorp/azuread"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.50.0"
    }
  }
}

provider "azurerm" {
  features {}
}
