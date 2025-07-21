output "resource_group_id" {
  value = azurerm_resource_group.rg.id
}

output "vm_id" {
  description = "ID único de la máquina virtual en Azure"
  value       = azurerm_linux_virtual_machine.vm.id
}

output "vm_private_ip" {
  description = "Dirección IP privada de la VM"
  value       = azurerm_network_interface.nic.private_ip_address
}

output "vm_public_ip" {
  description = "Dirección IP publica de la VM"
  value       = azurerm_public_ip.public_ip_1.ip_address
}