module "helm_release" {
  source  = "terraform-module/release/helm"
  version = "2.8.0"

  namespace         = var.namespace
  repository        = var.repository
  repository_config = var.repository_config

  app    = var.app
  values = var.values

  set = var.set

  set_sensitive = var.set_sensitive
}