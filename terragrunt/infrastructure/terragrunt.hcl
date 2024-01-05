inputs = {
  controllers = {
    name_prefix   = "talos-controller"
    quantity      = 2
    start_address = 61
    cores         = 2
    ram_gb        = 3
  }

  workers = {
    name_prefix   = "talos-worker"
    quantity      = 3
    start_address = 71
    cores         = 4
    ram_gb        = 4
  }

  proxmox = {
    target_node    = "proxmox"
    iso            = "local:iso/metal-amd64.iso"
    storage        = "local-lvm"
    subnet         = "192.168.1.0/24"
    gateway        = "192.168.1.1"
    dns            = ["192.168.1.21", "192.168.1.22"]
    search_domains = ["rhoades-brown.local"]
  }

  cluster = {
    name = "talos"
    #endpoint = "https://talos.rhoades-brown.local:6443"
    endpoint = "https://192.168.1.61:6443"
  }
}

terraform {
  source = "../terraform"
}
