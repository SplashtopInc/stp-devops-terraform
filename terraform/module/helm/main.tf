resource "helm_release" "this" {
  name             = var.name
  chart            = var.chart
  repository       = var.repository
  version          = var.chart_version
  namespace        = var.namespace
  verify           = var.verify
  skip_crds        = var.skip_crds
  create_namespace = var.create_namespace
  values           = var.values
  description      = var.description
}

