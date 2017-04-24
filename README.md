## Motivation

Show what a continuous delivery pipeline would look like with hashicorp tools including [Consul](https://www.consul.io/), [Terraform](https://www.terraform.io/) and [Packer](https://www.packer.io/).

## Requirements

* [Docker](https://www.docker.com/)
* [Terraform](https://www.terraform.io/)
* [Packer](https://www.packer.io/)

## Run commands

1. packer build -var 'app=consul' packer.json
2. packer build -var 'app=haproxy' packer.json
3. packer build -var 'app=nginx' packer.json
4. terraform plan
5. terraform apply