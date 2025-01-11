resource "azurerm_virtual_network" "task" {
  name                = "${local.project_prefix}-vnet"
  resource_group_name = azurerm_resource_group.task.name
  location            = azurerm_resource_group.task.location
  address_space       = ["10.0.0.0/8"]

  tags = {
    environment = local.environment
  }
}

resource "azurerm_subnet" "task" {
  name                 = "${local.project_prefix}-aks-subnet"
  resource_group_name  = azurerm_resource_group.task.name
  virtual_network_name = azurerm_virtual_network.task.name
  address_prefixes     = ["10.240.0.0/16"]
}