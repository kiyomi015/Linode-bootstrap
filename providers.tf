provider "linode" {
  token = var.linode_token != "" ? var.linode_token : null
}
