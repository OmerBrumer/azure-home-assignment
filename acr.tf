# locals {
#   acr_name = "${local.project_name}${local.environment}acr"
# }

# resource "azurerm_container_registry" "task" {
#   name                = local.acr_name
#   resource_group_name = azurerm_resource_group.task.name
#   location            = azurerm_resource_group.task.location
#   sku                 = "Basic"
#   admin_enabled       = true
# }