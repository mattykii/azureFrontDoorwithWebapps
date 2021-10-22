resource "azurerm_resource_group" "terraform_resource_group_example" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "terraform_vnet_example" {
  name                = var.vnet_name
  address_space       = var.address_space
  location            = azurerm_resource_group.terraform_resource_group_example.location
  resource_group_name = azurerm_resource_group.terraform_resource_group_example.name
}

resource "azurerm_subnet" "terraform_subnet_example" {
  for_each = var.subnet
  name                 = each.value.name
  resource_group_name  = azurerm_resource_group.terraform_resource_group_example.name
  virtual_network_name = azurerm_virtual_network.terraform_vnet_example.name
  address_prefixes     = each.value.prefix  
}  