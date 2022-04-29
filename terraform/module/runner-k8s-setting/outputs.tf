output "runner_namespace" {
  value = var.runner_namespace
}

output "runner_secret" {
  value = kubernetes_secret.runner-secrets.metadata[0].name
}

output "runner_deployment" {
  value = kubernetes_deployment.runner-deployment.metadata[0].name
}

output "runner_hpa" {
  value = kubernetes_horizontal_pod_autoscaler.runner-hpa.metadata[0].name
}