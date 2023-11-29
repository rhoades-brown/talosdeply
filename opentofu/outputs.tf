output "name" {
  value = module.controller[*].name
}

output "ipaddress" {
  value = module.controller[*].ipaddress
}

output "kubeconfig" {
  value = module.talos.kubeconfig
    sensitive = true
}

output "client_configuration" {
  value =  module.talos.client_configuration
  sensitive = true
}