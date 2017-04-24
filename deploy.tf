## Configure docker provider
provider "docker" {
  host = "unix:///var/run/docker.sock"
}

## Configure consul master resource
resource "docker_container" "consul-master" {
  name    = "consul-1"
  image   = "sixth-consul:latest"
  command = [ "/start.sh", "-node=consul-1" ]
  
  ports {
    internal = 8300
    external = 8300
  }
  ports {
    internal = 8301
    external = 8301
  }
  ports {
    internal = 8301
    external = 8301
    protocol = "udp"
  }
  ports {
    internal = 8302
    external = 8302
    protocol = "udp"
  }
  ports {
    internal = 8400
    external = 8400
  }
  ports {
    internal = 8500
    external = 8500
  }
  ports {
    internal = 53
    external = 8600
    protocol = "udp"
  }

}

resource "docker_container" "consul" {
  name    = "consul-${count.index+2}"
  image   = "sixth-consul:latest"
  count   = "2"
  env = ["CONSUL_IP=${docker_container.consul-master.ip_address}"]
  command = [ "/start.sh", "-node=consul-${count.index+2}" ]
}

## Configure nginx resource
resource "docker_container" "nginx" {
  name = "nginx-${count.index+1}"
  image = "sixth-nginx:latest"
  count = "3"
  env = ["CONSUL_IP=${docker_container.consul-master.ip_address}"]
  command = [ "/start.sh", "-node=nginx-${count.index+1}" ]

}

## Configure haproxy resource
resource "docker_container" "haproxy1" {
  name = "haproxy-1"
  image = "sixth-haproxy:latest"
  env = ["CONSUL_IP=${docker_container.consul-master.ip_address}"]
  command = [ "/start.sh", "-node=haproxy-1" ]
  ports {
    internal = 8001
    external = 8001
  }
  ports {
    internal = 80
    external = 80
}
}

resource "docker_container" "haproxy" {
  name = "haproxy-${count.index+2}"
  image = "sixth-haproxy:latest"
  count = "2"
  env = ["CONSUL_IP=${docker_container.consul-master.ip_address}"]
  command = [ "/start.sh", "-node=haproxy-${count.index+2}" ]
}
