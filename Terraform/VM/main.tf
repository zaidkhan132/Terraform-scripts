# Create Network Security Group
resource "azurerm_network_security_group" "nsg" {
  name                = "${var.cluster_name}-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name
}

# Add NSG Rules
resource "azurerm_network_security_rule" "nsg_rules" {
  count                       = length(var.nsg_rules)
  name                        = var.nsg_rules[count.index].name
  priority                    = var.nsg_rules[count.index].priority
  direction                   = var.nsg_rules[count.index].direction
  access                      = var.nsg_rules[count.index].access
  protocol                    = var.nsg_rules[count.index].protocol
  source_port_range           = var.nsg_rules[count.index].source_port_range
  destination_port_range      = var.nsg_rules[count.index].destination_port_range
  source_address_prefix       = var.nsg_rules[count.index].source_address_prefix
  destination_address_prefix  = var.nsg_rules[count.index].destination_address_prefix
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

# Create Network Interface
resource "azurerm_network_interface" "vm_nic" {
  count               = var.node_count
  name                = "${var.cluster_name}-nic-${count.index}"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id # Ensure `azurerm_subnet.subnet` exists and is properly referenced
    private_ip_address_allocation = "Dynamic"
  }

  # Attach NSG
  network_security_group_id = azurerm_network_security_group.nsg.id
}

# Create Virtual Machines
resource "azurerm_virtual_machine" "vm" {
  count               = var.node_count
  name                = "${var.cluster_name}-vm-${count.index}"
  location            = var.location
  resource_group_name = var.resource_group_name
  network_interface_ids = [
    azurerm_network_interface.vm_nic[count.index].id
  ]

  vm_size = "Standard_B2ms" # Update VM size based on requirements

  storage_os_disk {
    name              = "${var.cluster_name}-osdisk-${count.index}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "${var.cluster_name}-vm-${count.index}"
    admin_username = var.admin_username # Use variables for credentials
    admin_password = var.admin_password # Use variables for credentials
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}
