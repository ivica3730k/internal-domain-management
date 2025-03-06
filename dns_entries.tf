resource "cloudflare_record" "localhost-a-record" {
  type    = "A"
  ttl     = 60
  zone_id = var.CLOUDFLARE_ZONE_ID
  name    = "localhost.${var.ROOT_DOMAIN_NAME}"
  content = "127.0.0.1"
}

resource "cloudflare_record" "proxmox-a-record" {
  type    = "A"
  ttl     = 60
  zone_id = var.CLOUDFLARE_ZONE_ID
  name    = "proxmox.${var.ROOT_DOMAIN_NAME}"
  content = "192.168.1.43"
}

