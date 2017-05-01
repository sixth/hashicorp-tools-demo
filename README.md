## Motivation

Show what a continuous delivery pipeline would look like with hashicorp tools including [Consul](https://www.consul.io/), [Terraform](https://www.terraform.io/) and [Packer](https://www.packer.io/).

## Requirements

* [Docker](https://www.docker.com/)
* [Terraform](https://www.terraform.io/)
* [Packer](https://www.packer.io/)

## Tools used

| Tool        | Purpose          |
| ------------- |:-------------:| 
| consul template | dynamic haproxy config and nginx index file |
| alpine linux | mostly for disk space. 100-300MB~ on avg |

## Potentional todos

* Replace HAProxy with [fabio](https://github.com/fabiolb/fabio) / [Traefik](https://traefik.io/)
* Use [registrator](https://github.com/gliderlabs/registrator) to dynamically register containers
* Add more variables

## Run commands
```sh
$ packer build -var 'app=consul' packer.json
$ packer build -var 'app=haproxy' packer.json
$ packer build -var 'app=nginx' packer.json
$ terraform plan
$ terraform apply
```
### Test URLs
| Service        | URL           |
| ------------- |:-------------:| 
| consul      | http://127.0.0.1:8500 |
| haproxy      | http://127.0.0.1:8001 |
| nginx      | http://127.0.0.1:80 |
