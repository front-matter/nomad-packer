packer {
  required_plugins {
    digitalocean = {
      version = ">= 1.0.4"
      source  = "github.com/digitalocean/digitalocean"
    }
  }
}

variable "api_token" {
  sensitive = true  
}
variable "region" {
  default = "fra1"
}

source "digitalocean" "inveniordm" {
  api_token = var.api_token
  image     = "almalinux-9-x64"
  region    = var.region
  size      = "s-2vcpu-4gb-amd"
  ssh_username = "root"
  droplet_name = "inveniordm"
  snapshot_name = "inveniordm"
  monitoring = true
}

build {
  sources = ["source.digitalocean.inveniordm"]
}
