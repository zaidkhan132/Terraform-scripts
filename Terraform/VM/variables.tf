# General Variables
variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
}

variable "location" {
  description = "Azure region where resources will be deployed"
  type        = string
}

variable "node_count" {
  description = "Number of Virtual Machines to create in the cluster"
  type        = number
  default     = 1 # Added default value for convenience
}

variable "cluster_name" {
  description = "Cluster name to prefix resources"
  type        = string
}

# Network Security Group (NSG) Rules
variable "nsg_rules" {
  description = "List of Network Security Group (NSG) rules for the Virtual Machines"
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
    # Example Default Rule
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
  ] # Added example default to make initial deployments easier
}
