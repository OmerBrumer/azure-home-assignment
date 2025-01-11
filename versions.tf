terraform {
  required_version = ">= 1.6.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.0.0"
    }
  }

  # backend "azurerm" {
  #   storage_account_name = "p00devtfstate"
  #   container_name       = "tfstate"
  #   key                  = "dev"
  # }
}