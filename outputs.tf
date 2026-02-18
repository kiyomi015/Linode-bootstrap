output "instance_ids" {
  value       = { for k, inst in linode_instance.this : k => inst.id }
  description = "Instance IDs keyed by instance map key."
}

output "instance_ipv4" {
  value       = { for k, inst in linode_instance.this : k => inst.ipv4 }
  description = "Public IPv4 addresses keyed by instance map key."
}

output "instance_ipv6" {
  value       = { for k, inst in linode_instance.this : k => inst.ipv6 }
  description = "Public IPv6 addresses keyed by instance map key."
}
