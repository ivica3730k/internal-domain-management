# Generate a private key for LetsEncrypt account
resource "tls_private_key" "root-wildcard-reg-private-key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create an LetsEncrypt registration
resource "acme_registration" "root-wildcard-acme-registration" {
  account_key_pem = tls_private_key.root-wildcard-reg-private-key.private_key_pem
  email_address   = var.LETSENCRYPT_EMAIL_ADDRESS
}


resource "acme_certificate" "root-wildcard-certificate" {
  account_key_pem               = acme_registration.root-wildcard-acme-registration.account_key_pem
  common_name                   = "*.${var.ROOT_DOMAIN_NAME}"
  key_type                      = 4096
  min_days_remaining            = 45
  revoke_certificate_on_destroy = false
  dns_challenge {
    provider = "cloudflare"
    config = {
      CF_DNS_API_TOKEN               = var.CLOUDFLARE_TOKEN
      CLOUDFLARE_POOLING_INTERVAL    = "60"
      CLOUDFLARE_PROPAGATION_TIMEOUT = "3600"
    }
  }
}


resource "azurerm_storage_blob" "root-wildcard-certificate-crt-azure-blob" {
  name                   = "${var.ROOT_DOMAIN_NAME}.crt"
  storage_account_name   = azurerm_storage_account.storage-container.name
  storage_container_name = azurerm_storage_container.container.name
  type                   = "Block"
  source_content         = "${acme_certificate.root-wildcard-certificate.certificate_pem}${acme_certificate.root-wildcard-certificate.issuer_pem}"
  content_type           = "application/x-pem-file"

}

resource "azurerm_storage_blob" "root-wildcard-certificate-key-azure-blob" {
  name                   = "${var.ROOT_DOMAIN_NAME}.key"
  storage_account_name   = azurerm_storage_account.storage-container.name
  storage_container_name = azurerm_storage_container.container.name
  type                   = "Block"
  source_content         = acme_certificate.root-wildcard-certificate.private_key_pem
  content_type           = "application/x-pem-file"
}
