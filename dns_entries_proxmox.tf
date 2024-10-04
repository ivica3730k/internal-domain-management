resource "cloudflare_record" "proxmox-a-record" {
  type    = "A"
  ttl     = 60
  zone_id = var.CLOUDFLARE_ZONE_ID
  name    = "proxmox.${var.ROOT_DOMAIN_NAME}"
  content = "172.16.0.1"
}

resource "cloudflare_record" "internet-router-gw-proxmox-a-record" {
  type    = "A"
  ttl     = 60
  zone_id = var.CLOUDFLARE_ZONE_ID
  name    = "internet-router-gw.proxmox.${var.ROOT_DOMAIN_NAME}"
  content = "172.16.0.2"
}

resource "cloudflare_record" "hotspotshield-vpn-gw-proxmox-a-record" {
  type    = "A"
  ttl     = 60
  zone_id = var.CLOUDFLARE_ZONE_ID
  name    = "hotspotshield-vpn-gw.proxmox.${var.ROOT_DOMAIN_NAME}"
  content = "172.16.0.3"
}

resource "cloudflare_record" "zerotier-vpn-gw-proxmox-a-record" {
  type    = "A"
  ttl     = 60
  zone_id = var.CLOUDFLARE_ZONE_ID
  name    = "zerotier-vpn-gw.proxmox.${var.ROOT_DOMAIN_NAME}"
  content = "172.16.0.4"
}
