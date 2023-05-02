packer {
  required_plugins {
    digitalocean = {
      version = ">= 1.1.1"
      source  = "github.com/digitalocean/digitalocean"
    }
  }
}

variable "api_token" {
  description = "The API token for DigitalOcean"
  sensitive   = true
}

variable "region" {
  default = "fra1"
}

variable "size" {
  default = "g-2vcpu-8gb"
}

source "digitalocean" "nomad" {
  api_token      = var.api_token
  image          = "ubuntu-22-04-x64"
  region         = var.region
  size           = var.size
  ssh_username   = "root"
  droplet_name   = "nomad"
  snapshot_name  = "nomad"
  monitoring     = true
  user_data_file = "cloud-config.yaml"
  tags           = ["nomad"]
}

build {
  name    = "nomad"
  sources = ["source.digitalocean.nomad"]
}
