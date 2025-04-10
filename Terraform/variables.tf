variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
}

variable "storage_account_name" {
  description = "Name of the Azure Storage Account for backend state"
  type        = string
}

variable "container_name" {
  description = "Name of the Azure Blob container for backend state"
  type        = string
}

variable "arm_client_id" {
  description = "Azure Service Principal Client ID"
  type        = string
}

variable "arm_client_secret" {
  description = "Azure Service Principal Client Secret"
  type        = string
}

variable "arm_subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

variable "arm_tenant_id" {
  description = "Azure Tenant ID"
  type        = string
}

variable "cluster_name" {
  description = "Cluster name"
  type        = string
}

variable "location" {
  description = "Azure region for resources"
  type        = string
}

variable "node_count" {
  description = "Number of VMs to create"
  type        = number
  default     = 1
}

variable "nsg_rules" {
  description = "List of NSG rules"
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = string
    destination_port_range     = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
  default = [
    {
      name                       = "AllowSSH"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "TCP"
      source_port_range          = "*"
      destination_port_range     = "22"
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  ]
}
