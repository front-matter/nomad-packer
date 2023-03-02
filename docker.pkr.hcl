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
  run_command = ["-d", "-i", "-t", "--entrypoint=/bin/bash", "{{.Image}}"]
}

build {
  name = "front-matter/inveniordm"
  sources = [
    "source.docker.almalinux"
  ]

  provisioner "shell" {
    inline = [
      "dnf upgrade --refresh -y",
      "dnf install -y ansible-core"
    ]
  }

  provisioner "ansible-local" {
      playbook_file = "./ansible/playbooks/almalinux.yml"
    }

  post-processor "docker-tag" {
    repository = "front-matter/inveniordm"
    tags       = ["latest"]
    only       = ["docker.almalinux"]
  }
}
