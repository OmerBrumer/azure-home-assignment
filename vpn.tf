module "vpn" {
  source = "github.com/OmerBrumer/module-virtual-network-gateway.git?ref=dev"

  name                        = "${local.project_prefix}-vnet-gateway"
  resource_group_name         = azurerm_resource_group.task.name
  location                    = azurerm_resource_group.task.location
  subnet_id                   = azurerm_subnet.task["GatewaySubnet"].id
  enable_active_active        = true
  public_ip_sku               = "Standard"
  public_ip_allocation_method = "Static"

  vpn_client_configuration = {
    address_space        = "172.16.100.0/24"
    vpn_client_protocols = ["OpenVPN"]
    aad_tenant           = "c9ad96a7-2bac-49a7-abf6-8e932f60bf2b"
  }
  aad_audience = "41b23e61-6c1e-4545-b367-cd054e0ed4b4" # azure
}