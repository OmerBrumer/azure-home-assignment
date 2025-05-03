resource "azurerm_virtual_network" "task" {
  name                = "${local.project_prefix}-vnet"
  resource_group_name = azurerm_resource_group.task.name
  location            = azurerm_resource_group.task.location
  address_space       = ["10.0.0.0/8"]

  tags = {
    environment = local.environment
  }
}

locals {
  subnets = {
    AKSSubnet = {
      address_prefix = "10.0.0.0/20"
    },
    ACRSubnet = {
      address_prefix = "10.0.17.0/24"
    },
    InfrastructureSubnet = {
      address_prefix = "10.0.61.0/28"
    },
    AzureFirewallSubnet = {
      address_prefix = "10.0.16.0/26"
    },
    PESubnet = {
      address_prefix = "10.0.62.0/24"
    },
    GatewaySubnet = {
      address_prefix = "10.0.60.0/27"
    }
  }
}

resource "azurerm_subnet" "task" {
  for_each = local.subnets

  name                 = each.key
  resource_group_name  = azurerm_resource_group.task.name
  virtual_network_name = azurerm_virtual_network.task.name
  address_prefixes     = [each.value.address_prefix]
}