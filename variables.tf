variable "linode_token" {
  type        = string
  sensitive   = true
  default     = null
  description = "Linode API token. Prefer setting the LINODE_TOKEN environment variable."
}

variable "default_authorized_keys" {
  type        = list(string)
  default     = []
  description = "SSH public keys added to the root account on all instances."
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

    # Optional: create a non-root user via cloud-init at first boot.
    # password_hash must be a SHA-512 crypt hash — generate with:
    #   mkpasswd --method=SHA-512
    user = optional(object({
      name          = string
      password_hash = string
      ssh_key       = optional(string)
      sudo          = optional(bool, true)
      shell         = optional(string, "/bin/bash")
    }))
  }))

  default     = {}
  description = "Instances to manage. Set enabled=false to destroy an existing instance on apply."
}
