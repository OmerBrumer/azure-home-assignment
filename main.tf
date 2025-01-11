locals {
  project_name   = "p00"
  environment    = "dev"
  project_prefix = "${local.project_name}-${local.environment}"
  location       = "westeurope"
}

resource "azurerm_resource_group" "task" {
  name     = "${local.project_prefix}-rg"
  location = local.location

  tags = {
    environment = local.environment
  }
}