# Linode Deploy (OpenTofu)

Minimal OpenTofu config to create and configure Linode instances.

## Setup

```sh
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your token, SSH keys, and instance config
tofu init
```

## Usage

```sh
tofu plan
tofu apply
tofu destroy
```

Set `LINODE_TOKEN` in your environment to avoid storing the token in `terraform.tfvars`:

```sh
export LINODE_TOKEN="your-token"
```

## Delete an instance

Set that instance's `enabled` field to `false` in `terraform.tfvars`, then apply:

```sh
tofu apply
```

OpenTofu will destroy that Linode and remove it from outputs.

## Outputs

- `instance_ids` — instance IDs
- `instance_ipv4` — primary public IPv4 per instance
- `instance_ipv6` — public IPv6 per instance
- `ssh_connect` — ready-to-use SSH target (`user@ip`) per instance

## User creation

Set a `user` block on any instance to create a non-root user via cloud-init at first boot.
The `password_hash` must be a SHA-512 crypt hash — generate one with:

```sh
mkpasswd --method=SHA-512
```

SSH password auth is disabled automatically when a user block is present.
See `terraform.tfvars.example` for the full structure.

## Notes

- `terraform.tfvars` is gitignored — never commit it.
- If you do not set `authorized_keys`, you must set `root_pass` per instance.
