locals {
  active_instances = {
    for key, instance in var.instances : key => instance if try(instance.enabled, true)
  }
}

resource "linode_instance" "this" {
  for_each = local.active_instances

  label  = each.value.label
  region = each.value.region
  type   = each.value.type
  image  = each.value.image

  tags       = try(each.value.tags, [])
  private_ip = try(each.value.private_ip, false)

  authorized_keys = distinct(concat(var.default_authorized_keys, try(each.value.authorized_keys, [])))
  root_pass       = try(each.value.root_pass, null)
}
