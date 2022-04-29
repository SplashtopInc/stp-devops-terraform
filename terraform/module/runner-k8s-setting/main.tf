#--------------------------------
# Create kubernetes namespace
#--------------------------------
resource "kubernetes_namespace" "runner" {
  metadata {
    name = var.runner_namespace
  }
}

/*****************************************
  K8S secrets for configuring k8s runners
 *****************************************/
resource "kubernetes_secret" "runner-secrets" {
  metadata {
    // name      = var.runner_k8s_config
    generate_name = "${var.runner_k8s_config}-"
    namespace     = kubernetes_namespace.runner.metadata[0].name
  }
  data = {
    repo_url   = var.repo_url
    gh_token   = var.gh_token
    repo_owner = var.repo_owner
    repo_name  = var.repo_name
  }
  immutable = true
}

/*****************************************
  K8S deployment for configuring k8s runners
 *****************************************/
resource "kubernetes_deployment" "runner-deployment" {
  #checkov:skip=CKV_K8S_29:DinD need root permissions
  metadata {
    name      = "runner-dind-deployment"
    namespace = kubernetes_namespace.runner.metadata[0].name
    labels = {
      app = "runner"
    }
  }

  spec {
    replicas = var.pods_numbers

    selector {
      match_labels = {
        app = "runner"
      }
    }

    template {
      metadata {
        labels = {
          app = "runner"
        }
      }

      spec {
        container {
          name  = "runner"
          image = var.runner_iamge


          env {
            name = "ACTIONS_RUNNER_INPUT_URL"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.runner-secrets.metadata[0].name
                key  = "repo_url"
              }
            }
          }
          env {
            name = "GITHUB_TOKEN"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.runner-secrets.metadata[0].name
                key  = "gh_token"
              }
            }
          }
          env {
            name = "REPO_OWNER"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.runner-secrets.metadata[0].name
                key  = "repo_owner"
              }
            }
          }
          env {
            name = "REPO_NAME"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.runner-secrets.metadata[0].name
                key  = "repo_name"
              }
            }
          }
          env {
            name  = "DOCKER_HOST"
            value = "tcp://localhost:2375"
          }

          lifecycle {
            pre_stop {
              exec {
                command = ["/bin/bash", "-c", "./config.sh remove --token $(curl -sS --request POST --url \"https://api.github.com/repos/$${REPO_OWNER}/$${REPO_NAME}/actions/runners/remove-token\" --header \"authorization: Bearer $${GITHUB_TOKEN}\"  --header \"content-type: application/json\" | jq -r .token)"]
              }
            }
          }
          resources {
            limits = {
              cpu    = var.runner_resources_cpu_limits
              memory = var.runner_resources_memory_limits
            }
            requests = {
              cpu    = var.runner_resources_cpu_requests
              memory = var.runner_resources_memory_requests
            }
          }
        }
        container {
          name  = "dind"
          image = "docker:18.05-dind"

          resources {
            limits = {
              cpu    = var.dind_resources_cpu_limits
              memory = var.dind_resources_memory_limits
            }
            requests = {
              cpu    = var.dind_resources_cpu_requests
              memory = var.dind_resources_memory_requests
            }
          }

          security_context {
            privileged = true
          }
          volume_mount {
            name       = "dind-storage"
            mount_path = "/var/lib/docker"
          }
        }
        volume {
          name = "dind-storage"
          empty_dir {
            medium = ""
          }
        }
      }
    }
  }
}


/*****************************************
  K8S hpa for configuring k8s runners
 *****************************************/

resource "kubernetes_horizontal_pod_autoscaler" "runner-hpa" {
  metadata {
    name      = "runner-dind-deployment-hpa"
    namespace = kubernetes_namespace.runner.metadata[0].name
  }

  spec {
    max_replicas = 10
    min_replicas = 1

    scale_target_ref {
      kind = "Deployment"
      name = "runner-dind-deployment"
    }
    metric {
      type = "Resource"
      resource {
        name = "cpu"
        target {
          type                = "Utilization"
          average_utilization = 75
        }
      }
    }
  }
}