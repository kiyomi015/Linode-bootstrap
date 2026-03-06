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

## Run with just
```sh
just init
just plan
just apply
```

## Delete an instance
Set that instance's `enabled` field to `false` in `terraform.tfvars`, then apply:
```sh
tofu plan
tofu apply
```
Terraform/OpenTofu will destroy that Linode and remove it from outputs.

To destroy all managed infrastructure:
```sh
tofu destroy
```

## Outputs
- `instance_ids`
- `instance_ipv4`
- `instance_ipv6`

## Notes
- If you do not set `authorized_keys`, you must set `root_pass` per instance.
- Keep `terraform.tfvars` out of version control.
