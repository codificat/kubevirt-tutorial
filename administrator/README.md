# KubeVirt Workshop

This directory provides bases to deploy the lab.

## TODO

* Create GCP infra
  * Grafana uses a nodeport, 30300/tcp
  * KubeVirt Web UI has to be exposed as well
  * Create instances
* Make the terraform files more generic
  * Adapt it for GCP, if possible set the basis for adding more providers in the future
 
## Requirements

* Terraform (libvirt provider)
* Ansible
* A virtual machine (with nested virtualization)

## Installation

```shell
git clone https://github.com/tripledes/kubevirt-tutorial
cd kubevirt-tutorial
git checkout sjr-refactor
cd administrator/terraform
terraform init
terraform plan -var-file varfiles/<yourvarsfile>.tf
cd ../ansible
ANSIBLE_ROLES_PATH=roles ansible-playbook -i inventories/<inventory> -u cloud --private-key <ssh-private-key> playbooks/kubernetes.yml
```

## Versions used

| Component   | Version  |
| ----------- | -------- |
| Kubernetes  | stable-1 |
| kubevirt    | v0.17.0  |
| cdi         | 1.8.0    |

## Terraform variable file example

Variable files are used to override (and/or define) variables listed in [terraform variables definition file](terraform/variables.tf).

```hcl
libvirt_url="qemu+ssh://sjr@libvirt.domain.tld/system"
host_bridge_iface="br0"
dns_domain_name="domain.tld"
ssh_pub_key="ssh-rsa AAAABNzaC1yc2EAAAADAQABAAABAQC7ANGakwxmSNsDkvJ3ot0cBVeEIgRNAuCessDFd+6Uk2/zt+aewZn3DGPiWKy8VmprBncXhKIIO0mc1Sh4vnxL8jyho+YowVnD6SyByqkXOvmonY4gfUKEIb5aYMbXIc/wKfKLhWzrqki8HWGOESVxqx6WMN+mkBkarWeEjA7+ZpvpJXtgSZoh378WxnRb8v2Pm6qFgEFJK3kaKwdK/dNCsnnhuLxS0HHT/aTfVFA2rzPBYxbfJr2youztQLrVERxpBqYvov0ydoemdeMRQycNR7EY+fqkD1ABkpFKufZCTYcNuGiuhaOjkmU0uHtztwnV64I5mdeqrITRhHCF7y7"
hostname_prefix="kubevirtlab"
```
