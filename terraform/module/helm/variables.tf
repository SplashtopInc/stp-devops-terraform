variable "name" {
  description = "(Required) Release name"
  type        = string
  default     = ""
}

variable "chart" {
  description = "(Required) Chart name to be installed. The chart name can be local path, a URL to a chart, or the name of the chart if repository is specified"
  type        = string
  default     = ""
}

variable "repository" {
  description = "(Optional) Repository URL where to locate the requested chart."
  type        = string
  default     = ""
}

variable "chart_version" {
  type        = string
  default     = ""
  description = "Specify the exact chart version to install. If this is not specified, the latest version is installed."
}

variable "namespace" {
  description = "(Optional) The namespace to install the release into. Defaults to default"
  type        = string
  default     = "default"
}

variable "verify" {
  description = "(Optional) Verify the package before installing it. Helm uses a provenance file to verify the integrity of the chart"
  type        = bool
  default     = false
}

variable "skip_crds" {
  description = "(Optional) If set, no CRDs will be installed. By default, CRDs are installed if not already present."
  type        = bool
  default     = false
}

variable "create_namespace" {
  description = "(Optional) Create the namespace if it does not yet exist. Defaults to false."
  type        = bool
  default     = false
}

variable "values" {
  description = "(Optional) List of values in raw yaml to pass to helm. Values will be merged, in order, as Helm does with multiple -f options"
  type        = list(string)
  default     = null
}

variable "description" {
  description = "(Optional) Set release description attribute (visible in the history)."
  type        = string
  default     = ""
}