output "name" {
  value     =  proxmox_vm_qemu.this.name
}

output "ipaddress" {
    value = local.ipaddress
}
