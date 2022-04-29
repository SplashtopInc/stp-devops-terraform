### Site information ###
variable "runner_namespace" {
  type    = string
  default = "runner"
}

/**
 * Copyright 2020 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

variable "runner_k8s_config" {
  type        = string
  description = "Name for the k8s secret required to configure gh runners on EKS"
  default     = "runner-k8s-config"
}

variable "repo_url" {
  type        = string
  description = "Repo URL for the Github Action"
}

variable "repo_name" {
  type        = string
  description = "Name of the repo for the Github Action"
}

variable "repo_owner" {
  type        = string
  description = "Owner of the repo for the Github Action"
}

variable "gh_token" {
  type        = string
  description = "Github token that is used for generating Self Hosted Runner Token"
}

variable "runner_iamge" {
  type        = string
  description = "Github Action image"
  default     = "public.ecr.aws/k7c3r6j5/gh-runner:latest"
}

variable "pods_numbers" {
  type        = number
  description = "Number of the Github Action pods"
  default     = 2
}

variable "runner_resources_cpu_limits" {
  type        = string
  description = "runner container resources cpu limits"
  default     = "1"
}

variable "runner_resources_memory_limits" {
  type        = string
  description = "runner container resources memory limits"
  default     = "1024Mi"
}

variable "runner_resources_cpu_requests" {
  type        = string
  description = "runner container resources cpu limits"
  default     = "100m"
}

variable "runner_resources_memory_requests" {
  type        = string
  description = "runner container resources memory limits"
  default     = "256Mi"
}

variable "dind_resources_cpu_limits" {
  type        = string
  description = "dind container resources cpu limits"
  default     = "2"
}

variable "dind_resources_memory_limits" {
  type        = string
  description = "dind container resources memory limits"
  default     = "2048Mi"
}

variable "dind_resources_cpu_requests" {
  type        = string
  description = "dind container resources cpu requests"
  default     = "200m"
}

variable "dind_resources_memory_requests" {
  type        = string
  description = "dind container resources memory requests"
  default     = "512Mi"
}