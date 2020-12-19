# Droplet
variable "droplet_name" {}
variable "tf_ssh_keys" {}
variable "image" {
  default = "docker-20-04"
}
variable "region" {
  default = "fra1"
}
variable "size" {
  default = "s-1vcpu-2gb"
}
# Record
variable "zone_id" {}
variable "record_name" {}

resource "digitalocean_droplet" "main" {
  image    = var.image
  name     = var.droplet_name
  region   = var.region
  size     = var.size
  ssh_keys = var.tf_ssh_keys
}

resource "cloudflare_record" "main" {
  zone_id = var.zone_id
  name    = var.record_name
  value   = digitalocean_droplet.main.ipv4_address
  type    = "A"
  proxied = false
}

output "droplet" {
  value = digitalocean_droplet.main
}

output "record" {
  value = cloudflare_record.main
}
