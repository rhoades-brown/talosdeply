locals {
  nameserver    = join(" ", var.proxmox.dns)
  search_domain = join(" ", var.proxmox.search_domains)
}

module "controller" {
  source        = "./modules/proxmox-template"
  count         = var.controllers.quantity
  name          = "${var.controllers.name_prefix}-${count.index + 1}"
  description   = "Talos controller node ${count.index + 1}"
  hostnumber    = count.index + 1
  gateway       = var.proxmox.gateway
  subnet        = var.proxmox.subnet
  start_address = var.controllers.start_address
  ram           = var.controllers.ram_gb
  cores         = var.controllers.cores
  target_node   = var.proxmox.target_node
  storage       = var.proxmox.storage
  nameserver    = local.nameserver
  search_domain = local.search_domain
}

module "worker" {
  source        = "./modules/proxmox-template"
  count         = var.workers.quantity
  name          = "${var.workers.name_prefix}-${count.index + 1}"
  description   = "Talos worker node ${count.index + 1}"
  hostnumber    = count.index + 1
  gateway       = var.proxmox.gateway
  subnet        = var.proxmox.subnet
  start_address = var.workers.start_address
  ram           = var.workers.ram_gb
  cores         = var.workers.cores
  target_node   = var.proxmox.target_node
  storage       = var.proxmox.storage
  nameserver    = local.nameserver
  search_domain = local.search_domain
}

module "talos" {
  source           = "./modules/talos"
  cluster_name     = var.cluster.name
  cluster_endpoint = var.cluster.endpoint
  controllers      = module.controller
  workers          = module.worker
  depends_on       = [module.controller, module.worker]
}

module "sealed-secrets" {
  source     = "./modules/sealed-secrets"
  depends_on = [module.talos]
}

module "argocd" {
  source     = "./modules/argocd"
  depends_on = [module.sealed-secrets]
}
