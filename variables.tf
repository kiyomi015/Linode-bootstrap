variable "linode_token" {
  type        = string
  sensitive   = true
  default     = ""
  description = "Linode API token. Prefer setting the LINODE_TOKEN environment variable."
}

variable "default_authorized_keys" {
  type        = list(string)
  default     = []
  description = "SSH public keys added to all instances."
}

variable "instances" {
  type = map(object({
    label           = string
    region          = string
    type            = string
    image           = string
    tags            = optional(list(string), [])
    authorized_keys = optional(list(string), [])
    root_pass       = optional(string)
    private_ip      = optional(bool, false)
  }))

  default     = {}
  description = "Instances to create. Map keys are instance IDs used in outputs."
}
