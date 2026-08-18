resource "azurerm_resource_group" "phillies" {
  location = "eastus2"
  name     = "rg-cloudsports-mlb-phillies"

  tags = {
    City   = "Philadelphia"
    League = "MLB"
    Team   = "Phillies"
  }
}

resource "azurerm_virtual_network" "phillies" {
  address_space       = ["10.12.0.0/16"]
  location            = azurerm_resource_group.phillies.location
  name                = "vnet-cloudsports-mlb-phillies-eus2"
  resource_group_name = azurerm_resource_group.phillies.name

  tags = {
    City   = "Philadelphia"
    League = "MLB"
    Team   = "Phillies"
  }
}

resource "azurerm_subnet" "workload" {
  address_prefixes                = ["10.12.0.0/24"]
  default_outbound_access_enabled = false
  name                            = "snet-workload"
  resource_group_name             = azurerm_resource_group.phillies.name
  virtual_network_name            = azurerm_virtual_network.phillies.name
}