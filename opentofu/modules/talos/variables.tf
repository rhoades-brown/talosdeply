variable "cluster_name" {
  type        = string
  description = "The name of the cluster"
}

variable "cluster_endpoint" {
  type        = string
  description = "The cluster endpoint"
}

variable "workers" {
  type = list(object({
    name      = string
    ipaddress = string
  }))
}

variable "controllers" {
  type = list(object({
    name      = string
    ipaddress = string
  }))
}
