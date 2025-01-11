data "azurerm_subscription" "current" {}

provider "azurerm" {
  subscription_id = data.azurerm_subscription.current
  features {}
}