variable "digitalocean_token" {}
provider "digitalocean" {
  token = var.digitalocean_token
}

variable "cloudflare_api_token" {}
provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

locals {
  // sikademo.com zone id
  zone_id      = "f2c00168a7ecd694bb1ba017b332c019"
  ssh_key_name = "ondrejsika"
}

data "digitalocean_ssh_key" "ondrejsika" {
  name = local.ssh_key_name
}

module "ondrejsika-do-droplet-example" {
  source = "../."
  tf_ssh_keys = [
    data.digitalocean_ssh_key.ondrejsika.id
  ]
  zone_id      = local.zone_id
  droplet_name = "example"
  record_name  = "example"
}
