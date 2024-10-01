resource "cloudflare_record" "localhost-a-record" {
  type    = "A"
  ttl     = 60
  zone_id = var.CLOUDFLARE_ZONE_ID
  name    = "localhost.${var.ROOT_DOMAIN_NAME}"
  content = "127.0.0.1"
}
