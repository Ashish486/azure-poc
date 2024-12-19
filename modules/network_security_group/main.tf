resource "azurerm_network_security_group" "nsg" {
  name                = var.nsg_name
  resource_group_name = var.rg_name
  location            = var.location
}

resource "azurerm_network_security_rule" "rdp" {
  name                        = "allowRDP"
  priority                    = 1000
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3389"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.rg_name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

output "nsg_id" {
  value = azurerm_network_security_group.nsg.id
}