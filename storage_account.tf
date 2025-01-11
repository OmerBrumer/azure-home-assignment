locals {
  tfstate_storage_account_name = "${local.project_name}${local.environment}tfstate"
}

resource "azurerm_storage_account" "task" {
  name                     = local.tfstate_storage_account_name
  resource_group_name      = azurerm_resource_group.task.name
  location                 = azurerm_resource_group.task.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = local.environment
  }
}

locals {
  storage_account_container_name = "terraform"
}

resource "azurerm_storage_container" "task" {
  name                  = local.storage_account_container_name
  storage_account_id    = azurerm_storage_account.task.id
  container_access_type = "private"
}