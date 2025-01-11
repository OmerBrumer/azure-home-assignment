# locals {
#   aks_cluster_name = "${local.project_prefix}-aks"
# }

# resource "azurerm_kubernetes_cluster" "task" {
#   name                       = local.aks_cluster_name
#   location                   = azurerm_resource_group.task.location
#   resource_group_name        = azurerm_resource_group.task.name
#   dns_prefix_private_cluster = "p00devaks"

#   default_node_pool {
#     name           = "${local.aks_cluster_name}-nodepool"
#     node_count     = 2
#     vm_size        = "Standard_DS2_v2"
#     vnet_subnet_id = azurerm_subnet.task.id
#   }

#   identity {
#     type = "SystemAssigned"
#   }

#   network_profile {
#     network_plugin = "azure"
#   }

#   private_cluster_enabled = true

#   tags = {
#     environment = local.environment
#   }
# }