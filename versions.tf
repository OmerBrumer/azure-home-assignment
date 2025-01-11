terraform {
  required_version = ">= 1.6.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.0.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "p00-dev-rg"
    storage_account_name = "p00devtfstate"
    container_name       = "terraform"
    key                  = "dev"
  }
}