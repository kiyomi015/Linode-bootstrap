set dotenv-load := false
set shell := ["bash", "-euo", "pipefail", "-c"]

TOFU := "tofu"

[doc('List available commands.')]
[group('Help')]
@default:
    just --list

[doc('Initialize OpenTofu providers and modules.')]
[group('OpenTofu lifecycle')]
init:
    {{TOFU}} init

[doc('Format OpenTofu files in this project.')]
[group('OpenTofu lifecycle')]
fmt:
    {{TOFU}} fmt -recursive

[doc('Validate OpenTofu configuration.')]
[group('OpenTofu lifecycle')]
validate:
    {{TOFU}} validate

[doc('Create and show an execution plan.')]
[group('OpenTofu lifecycle')]
plan:
    {{TOFU}} plan

[doc('Apply the current OpenTofu plan.')]
[group('OpenTofu lifecycle')]
apply:
    {{TOFU}} apply

[doc('Destroy all resources managed by this state.')]
[group('OpenTofu lifecycle')]
destroy:
    {{TOFU}} destroy

[doc('Show all OpenTofu outputs.')]
[group('Outputs')]
output:
    {{TOFU}} output

[doc('Show instance IPv4 output map.')]
[group('Outputs')]
output-ipv4:
    {{TOFU}} output instance_ipv4

[doc('Show instance ID output map.')]
[group('Outputs')]
output-ids:
    {{TOFU}} output instance_ids
