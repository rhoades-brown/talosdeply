output "kubeconfig" {
  value     = module.talos.kubeconfig.kubeconfig_raw
  sensitive = true
}

output "client_configuration" {
  value     = module.talos.client_configuration
  sensitive = true
}
