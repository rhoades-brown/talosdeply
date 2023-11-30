resource "helm_release" "sealed-secrets" {
  name       = "sealed-secrets"
  repository = "https://bitnami-labs.github.io/sealed-secrets"
  chart      = "sealed-secrets"
  version    = "v2.13.3"
  namespace  = "kube-system"

  set {
    name  = "fullnameOverride"
    value = "sealed-secrets-controller"
  }
}
