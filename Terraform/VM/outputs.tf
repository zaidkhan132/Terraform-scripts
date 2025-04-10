output "vm_ids" {
  description = "IDs of the created VMs"
  value       = azurerm_virtual_machine.vm[*].id
}

output "public_ips" {
  description = "Public IPs of the VMs"
  value       = azurerm_network_interface.vm_nic[*].private_ip_address
}
