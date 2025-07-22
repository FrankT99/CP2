terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.37"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "30bd9943-ebe3-4c65-9be0-128abd1d600b"
}