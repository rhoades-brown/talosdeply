resource "proxmox_cloud_init_disk" "ci" {
  name     = var.name
  pve_node = var.target_node
  storage  = "local"

  meta_data = yamlencode({
    instance_id    = sha1(var.name)
    local-hostname = var.name
  })

  network_config = yamlencode({
    version = 1
    config = [{
      type = "physical"
      name = "eth0"
      subnets = [{
        type    = "static"
        address = "${local.ipaddress}/${local.subnet}"
        gateway = var.gateway
        dns_nameservers = var.dns
      }]
    }]
  })
}



/* Uses Cloud-Init options from Proxmox 5.2 */
resource "proxmox_vm_qemu" "this" {
  name        = var.name
  desc        = var.description
  target_node = var.target_node
  cores       = var.cores
  memory      = var.ram * 1024
  clone       = "talos"
  scsihw      = "virtio-scsi-single"
  cpu         = "x86-64-v2-AES"
  full_clone  = false
  #tablet                  = false
  automatic_reboot = true
  agent            = 1
  balloon          = 2048
  #boot                    = "order=virtio0"
  qemu_os = "l26"
  os_type = "cloud-init"
  machine = "q35"
  #  cloudinit_cdrom_storage = var.storage
  ipconfig0    = "ip=${local.ipaddress}/${local.subnet},gw=${var.gateway}"
  nameserver   = var.nameserver
  searchdomain = var.search_domain

  network {
    model     = "virtio"
    bridge    = "vmbr0"
    firewall  = false
    link_down = false
  }

  disks {
    virtio {
      virtio0 {
        disk {
          size      = "18432M"
          storage   = var.storage
          iothread  = true
          replicate = true
        }
      }
    }
    scsi {
      scsi0 {
        cdrom {
          iso = proxmox_cloud_init_disk.ci.id
        }
      }
    }
  }
}

locals {
  ipaddress = cidrhost(var.subnet, var.start_address + var.hostnumber)
  subnet    = element(split("/", var.subnet), 1)
}
