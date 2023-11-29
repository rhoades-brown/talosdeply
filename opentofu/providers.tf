terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "2.9.14"
    }
    talos = {
      source  = "siderolabs/talos"
      version = "0.4.0-alpha.0"
    }
  }
}

provider "proxmox" {
  pm_api_url = "https://proxmox.rhoades-brown.local:8006/api2/json"
  pm_debug   = true
}


provider "talos" {
  # Configuration options}
}