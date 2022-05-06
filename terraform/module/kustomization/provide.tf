provider "kustomization" {
  alias = "example"

  # one of kubeconfig_path, kubeconfig_raw or kubeconfig_incluster must be set

  ### kubeconfig_path - Path to a kubeconfig file. Can be set using KUBECONFIG_PATH environment variable. ###
  # kubeconfig_path = "~/.kube/config"
  # can also be set using KUBECONFIG_PATH environment variable

  ### kubeconfig_raw - Raw kubeconfig file. If kubeconfig_raw is set, kubeconfig_path is ignored. ###
  # kubeconfig_raw = data.template_file.kubeconfig.rendered
  # kubeconfig_raw = yamlencode(local.kubeconfig)

  ### kubeconfig_incluster Set to true when running inside a kubernetes cluster. ###
  # kubeconfig_incluster = true
}