## Creacion Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location_name

  tags = {
    enviroment = "CP2"
  }
}

## Creacion ACR
resource "azurerm_container_registry" "acr" {
  name                = "ACRvCP2" # debe ser único en Azure
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Standard"
  admin_enabled       = false

  tags = {
    enviroment = "CP2"
  }
}

resource "azurerm_user_assigned_identity" "acr_identity" {
  name                = "ACR-CP2-Identity"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
}

resource "azurerm_role_assignment" "acr_push_pull" {
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "AcrPush" #Permisos Pull y Push
  principal_id         = azurerm_user_assigned_identity.acr_identity.principal_id
}

## Creacion Virtual Machines
resource "azurerm_linux_virtual_machine" "vm" {
  name                            = var.virtual_machine_vm_name
  location                        = azurerm_resource_group.rg.location
  resource_group_name             = azurerm_resource_group.rg.name
  size                            = "Standard_A1_v2"
  network_interface_ids           = [azurerm_network_interface.nic.id]
  admin_username                  = var.admin_username
  disable_password_authentication = true

  admin_ssh_key {
    username   = var.admin_username
    public_key = file("C:\\claves_ssh\\id_rsa.pub")
  }

  os_disk {
    name                 = "${var.virtual_machine_vm_name}-disk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-LTS"
    version   = "latest"
  }

  tags = {
    enviroment = "CP2"
  }
}