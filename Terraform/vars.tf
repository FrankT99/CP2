variable "resource_group_name" {
  type    = string
  default = "rg-createdbyTF"
}

variable "location_name" {
  type    = string
  default = "westeurope"
}

variable "virtual_machine_vm_name" {
  type    = string
  default = "vm"
}

variable "admin_username" {
  type      = string
  default   = "user"
  sensitive = true
}