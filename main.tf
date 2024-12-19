cterraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.2.0"
    }
  }
}


provider "azurerm" {
  features {}
}

module "resource_group" {
  source = "./modules/resource_group"
  rg_name = var.rg_name
  location = var.location
}

module "virtual_network" {
  source = "./modules/virtual_network"
  vnet_name = var.vnet_name
  rg_name = module.resource_group.rg_name
  location = var.location
  address_space = var.address_space
   subnet_name = var.subnet_name
}

module "availability_set" {
  source = "./modules/availability_set"
  as_name = var.as_name
  rg_name = module.resource_group.rg_name
  location = var.location
}

module "network_security_group" {
  source = "./modules/network_security_group"
  nsg_name = var.nsg_name
  rg_name = module.resource_group.rg_name
  location = var.location
}

module "virtual_machine" {
  source = "./modules/virtual_machine"
  vm_name = var.vm_name
  rg_name = module.resource_group.rg_name
  location = var.location
  as_id = module.availability_set.as_id
   subnet_id = module.virtual_network.subnet_id
  vnet_name = module.virtual_network.vnet_name
   subnet_name = var.subnet_name
  nsg_id = module.network_security_group.nsg_id
  admin_username = var.admin_username
  admin_password = var.admin_password
}