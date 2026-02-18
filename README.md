# Linode Deploy (OpenTofu)

Minimal OpenTofu config to create Linode instances.

## Run
```sh
cp terraform.tfvars.example terraform.tfvars
export LINODE_TOKEN="your-token"   # or set linode_token in terraform.tfvars
tofu init
tofu plan
tofu apply
```

## Outputs
- `instance_ids`
- `instance_ipv4`
- `instance_ipv6`

## Notes
- If you do not set `authorized_keys`, you must set `root_pass` per instance.
- Keep `terraform.tfvars` out of version control.
