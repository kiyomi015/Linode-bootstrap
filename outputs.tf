output "instance_ids" {
  value       = { for k, inst in linode_instance.this : k => inst.id }
  description = "Instance IDs keyed by instance map key."
}

output "instance_ipv4" {
  value       = { for k, inst in linode_instance.this : k => inst.ipv4[0] }
  description = "Primary public IPv4 address keyed by instance map key."
}

output "instance_ipv6" {
  value       = { for k, inst in linode_instance.this : k => inst.ipv6 }
  description = "Public IPv6 address keyed by instance map key."
}

output "ssh_connect" {
  value = {
    for k, inst in linode_instance.this : k =>
    format("%s@%s",
      var.instances[k].user != null ? var.instances[k].user.name : "root",
      inst.ipv4[0]
    )
  }
  description = "SSH connection target (user@ipv4) for each instance."
}
