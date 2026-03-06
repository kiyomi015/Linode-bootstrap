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

variable "provisioning_ssh_private_key_path" {
  type        = string
  default     = "~/.ssh/id_ed25519"
  description = "Deprecated: retained for compatibility; post-provisioning remote-exec is no longer used."
}

variable "instances" {
  type = map(object({
    label           = string
    region          = string
    type            = string
    image           = string
    enabled         = optional(bool, true)
    tags            = optional(list(string), [])
    authorized_keys = optional(list(string), [])
    root_pass       = optional(string)
    private_ip      = optional(bool, false)
    provisioning = optional(object({
      enabled              = optional(bool, false)
      ssh_private_key_path = optional(string)
      user = optional(object({
        name     = string
        password = string
        shell    = optional(string, "/bin/bash")
        sudo     = optional(bool, true)
      }))
    }), {})
  }))

  default     = {}
  description = "Instances to manage. Set enabled=false to destroy an existing instance on apply."
}
