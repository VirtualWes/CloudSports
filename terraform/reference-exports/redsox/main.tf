resource "azurerm_resource_group" "res-0" {
  location = "eastus2"
  name     = "rg-cloudsports-mlb-redsox"
  tags = {
    City   = "Boston"
    League = "MLB"
    Team   = "RedSox"
  }
}
resource "azurerm_virtual_network" "res-1" {
  address_space       = ["10.11.0.0/16"]
  location            = "eastus2"
  name                = "vnet-cloudsports-mlb-redsox-eus2"
  resource_group_name = azurerm_resource_group.res-0.name
  tags = {
    League = "MLB"
  }
}
resource "azurerm_subnet" "res-2" {
  address_prefixes                = ["10.11.0.0/24"]
  default_outbound_access_enabled = false
  name                            = "defaultsnet-workload"
  resource_group_name             = azurerm_resource_group.res-0.name
  virtual_network_name            = "vnet-cloudsports-mlb-redsox-eus2"
  depends_on = [
    azurerm_virtual_network.res-1,
  ]
}
