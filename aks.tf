locals {
  aks_cluster_name    = "${local.project_prefix}-aks"
  aks_dns_prefix_name = "p00devaks"
}

resource "azurerm_private_dns_zone" "aks" {
  name                = "privatelink.westeurope.azmk8s.io"
  resource_group_name = azurerm_resource_group.task.name
}

resource "azurerm_user_assigned_identity" "aks" {
  name                = "aks-identity"
  resource_group_name = azurerm_resource_group.task.name
  location            = azurerm_resource_group.task.location
}

resource "azurerm_role_assignment" "aks" {
  scope                = azurerm_virtual_network.task.id
  role_definition_name = "Private DNS Zone Contributor"
  principal_id         = azurerm_user_assigned_identity.aks.principal_id
}

resource "azurerm_role_assignment" "aks_private_dns_zone" {
  scope                = azurerm_private_dns_zone.aks.id
  role_definition_name = "Private DNS Zone Contributor"
  principal_id         = azurerm_user_assigned_identity.aks.principal_id
}

resource "azurerm_kubernetes_cluster" "task" {
  name                       = local.aks_cluster_name
  location                   = azurerm_resource_group.task.location
  resource_group_name        = azurerm_resource_group.task.name
  dns_prefix_private_cluster = local.aks_dns_prefix_name
  private_cluster_enabled    = true
  kubernetes_version         = "1.31.1"
  private_dns_zone_id        = azurerm_private_dns_zone.aks.id
  private_cluster_public_fqdn_enabled = true

  default_node_pool {
    name           = "ds2pool"
    node_count     = 2
    vm_size        = "Standard_DS2_v2"
    vnet_subnet_id = azurerm_subnet.task["AKSSubnet"].id
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.aks.id]
  }

  network_profile {
    network_plugin = "azure"
    service_cidr   = "10.240.0.0/16"
    dns_service_ip = "10.240.0.10"
  }

  tags = {
    environment = local.environment
  }

  depends_on = [
    azurerm_role_assignment.aks,
  ]
}