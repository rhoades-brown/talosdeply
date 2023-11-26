terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "2.9.14"
    }
  }
}


provider "proxmox" {
  pm_api_url = "https://proxmox.rhoades-brown.local:8006/api2/json"
  pm_debug   = true
}