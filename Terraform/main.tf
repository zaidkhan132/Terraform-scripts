terraform {
  backend "azurerm" {
    resource_group_name  = "StaticResourceGroupName"  # Replace with actual values
    storage_account_name = "StaticStorageAccountName" # Replace with actual values
    container_name       = "StaticContainerName"      # Replace with actual values
    key                  = "terraform.tfstate"
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
    }
  }
}

provider "azurerm" {
  features {}

  subscription_id = "03eddb61-8398-483b-9327-8dc016e1af21"
  client_id       = "bdd9ac31-6d49-4d59-84f3-52fade49fbc4"
  client_secret   = "mU58Q~bY3L5ZpogpdiVMGVrygWt2lgepMYpwRcjB"
  tenant_id       = "c10f8df0-e818-4423-b387-68ce113e39cc"
}

# Create Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# Use VM Module
module "azure_vms" {
  source              = "./VM"
  cluster_name        = var.cluster_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  node_count          = var.node_count
}
