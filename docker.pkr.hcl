packer {
  required_plugins {
    docker = {
      version = ">= 1.0.1"
      source  = "github.com/hashicorp/docker"
    }
  }
}

source "docker" "almalinux" {
  image       = "almalinux:9"
  commit      = true
}

build {
  name = "inveniordm"
  sources = [
    "source.docker.almalinux"
  ]

  post-processor "docker-tag" {
    repository = "front-matter/inveniordm"
    tags       = ["almalinux9"]
    only       = ["docker.ubuntu"]
  }
}
