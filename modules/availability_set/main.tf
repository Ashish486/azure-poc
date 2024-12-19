resource "azurerm_availability_set" "as" {
  name                = var.as_name
  resource_group_name = var.rg_name
  location            = var.location
  
}

output "as_id" {
  value = azurerm_availability_set.as.id
}