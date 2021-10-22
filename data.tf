
data "azurerm_resource_group" "kata1ResourceGroup" {
  name = "terraformKata01"

  depends_on = [module.module_for_RG_vnet_and_subnet]
}