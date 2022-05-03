variable "name" {
  type    = string
  default = "1 weeks of daily snapshots"
}

variable "state" {
  type        = string
  description = "Whether the lifecycle policy should be enabled or disabled. ENABLED or DISABLED are valid values"
  default     = "ENABLED"
}

variable "interval" {
  type        = number
  default     = 24
  description = "How often this lifecycle policy should be evaluated. 1,2,3,4,6,8,12 or 24 are valid values."
}

variable "interval_unit" {
  type        = string
  default     = "HOURS"
  description = "The unit for how often the lifecycle policy should be evaluated. HOURS is currently the only allowed value and also the default value"
}

variable "times" {
  type        = list(any)
  default     = ["23:45"]
  description = "A list of times in 24 hour clock format that sets when the lifecycle policy should be evaluated"
}

variable "keep_days" {
  type        = number
  default     = 7
  description = "(Optional) A list of times in 24 hour clock format that sets when the lifecycle policy should be evaluated. Max of 1"
}

variable "target_tags" {
  type        = map(any)
  description = "(Optional) A map of tag keys and their values. Any resources that match the resource_types and are tagged with any of these tags will be targeted"
  default = {
    DLM-snapshot = true
  }
}
