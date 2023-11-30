output "kubeconfig" {
  value     = module.talos.kubeconfig.kubeconfig_raw
  sensitive = true
}

output "client_configuration" {
  value     = module.talos.client_configuration
  sensitive = true
}

output "client_certificate" {
  value     = module.talos.kubeconfig.kubernetes_client_configuration.client_certificate
  sensitive = true
}

output "client_key" {
  value     = module.talos.kubeconfig.kubernetes_client_configuration.client_key
  sensitive = true
}

output "cluster_ca_certificate" {
  value     = module.talos.kubeconfig.kubernetes_client_configuration.ca_certificate
  sensitive = true
}
