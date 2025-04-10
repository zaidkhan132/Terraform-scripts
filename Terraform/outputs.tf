output "vm_ids" {
  description = "IDs of the created VMs"
  value       = module.azure_vms.vm_ids
}

output "public_ips" {
  description = "Public IP addresses of the created VMs"
  value       = module.azure_vms.public_ips
}
