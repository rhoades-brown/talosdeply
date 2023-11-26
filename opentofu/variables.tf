variable "controllers" {
  type = object({
    name_prefix   = string
    quantity      = number
    cores         = number
    ram_gb        = number
    start_address = number
  })
  description = "controller node definition"
}

variable "workers" {
  type = object({
    name_prefix   = string
    quantity      = number
    cores         = number
    ram_gb        = number
    start_address = number
  })
  description = "worker node definitions"
}


variable "proxmox" {
  type = object({
    target_node    = string
    iso            = string
    storage        = string
    subnet         = string
    gateway        = string
    dns            = list(string)
    search_domains = list(string)
  })
}