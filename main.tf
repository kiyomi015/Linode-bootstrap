locals {
  active_instances = {
    for key, instance in var.instances : key => instance if try(instance.enabled, true)
  }

  # Build a base64-encoded cloud-init config for each instance that defines a user.
  # Lines are built conditionally so optional fields (ssh_key, sudo) are only
  # included when set, keeping the resulting YAML clean.
  cloud_init_configs = {
    for key, instance in local.active_instances : key => instance.user != null ? base64encode(
      join("\n", compact([
        "#cloud-config",
        "ssh_pwauth: false",
        "package_update: true",
        "users:",
        "  - name: ${instance.user.name}",
        "    passwd: ${instance.user.password_hash}",
        "    lock_passwd: false",
        instance.user.ssh_key != null ? "    ssh_authorized_keys:" : null,
        instance.user.ssh_key != null ? "      - ${instance.user.ssh_key}" : null,
        instance.user.sudo ? "    sudo: ALL=(ALL) NOPASSWD:ALL" : null,
        "    shell: ${instance.user.shell}",
      ]))
    ) : null
  }
}

resource "linode_instance" "this" {
  for_each = local.active_instances

  label  = each.value.label
  region = each.value.region
  type   = each.value.type
  image  = each.value.image

  tags       = each.value.tags
  private_ip = each.value.private_ip

  authorized_keys = distinct(concat(var.default_authorized_keys, each.value.authorized_keys))
  root_pass       = each.value.root_pass

  dynamic "metadata" {
    for_each = local.cloud_init_configs[each.key] != null ? [1] : []
    content {
      user_data = local.cloud_init_configs[each.key]
    }
  }
}
