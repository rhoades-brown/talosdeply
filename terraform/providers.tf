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

    helm = {
      source  = "hashicorp/helm"
      version = "2.12.1"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.24.0"
    }
  }
}

provider "proxmox" {
  pm_api_url = "https://proxmox.rhoades-brown.local:8006/api2/json"
  pm_debug   = true
}

provider "talos" {
  # Configuration options
}


provider "helm" {
  kubernetes {
    host = var.cluster.endpoint

    client_certificate     = base64decode(module.talos.kubeconfig.kubernetes_client_configuration.client_certificate)
    client_key             = base64decode(module.talos.kubeconfig.kubernetes_client_configuration.client_key)
    cluster_ca_certificate = base64decode(module.talos.kubeconfig.kubernetes_client_configuration.ca_certificate)
  }
}

provider "kubernetes" {
  host = var.cluster.endpoint

  client_certificate     = base64decode(module.talos.kubeconfig.kubernetes_client_configuration.client_certificate)
  client_key             = base64decode(module.talos.kubeconfig.kubernetes_client_configuration.client_key)
  cluster_ca_certificate = base64decode(module.talos.kubeconfig.kubernetes_client_configuration.ca_certificate)
}
