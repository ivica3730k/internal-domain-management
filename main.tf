terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.3.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "3.0.1"
    }
    acme = {
      source  = "vancluever/acme"
      version = "2.26.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.43.0"
    }
  }
  backend "azurerm" {
    # will get configured with -backend-config= in the terraform init -upgrade command
    # the backend config file will be created using envsubst and provider_secrets_template file
    # env vars are set in the github action
    # env vars used in provider_secrets_template file are also used in the variable blocks below
    # to configure the azurerm provider
  }
}

provider "azurerm" {
  features {
    key_vault {
      # purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults   = false
      recover_soft_deleted_certificates = false
      recover_soft_deleted_secrets      = false
      recover_soft_deleted_keys         = false
    }
    template_deployment {
      delete_nested_items_during_deletion = false
    }
  }
  subscription_id = var.SUBSCRIPTION_ID
  tenant_id       = var.TENANT_ID
  client_id       = var.CLIENT_ID
  client_secret   = var.CLIENT_SECRET
}

provider "azuread" {
  tenant_id     = var.TENANT_ID
  client_id     = var.CLIENT_ID
  client_secret = var.CLIENT_SECRET
}

provider "acme" {
  server_url = "https://acme-v02.api.letsencrypt.org/directory"
}

provider "cloudflare" {
  api_token = var.CLOUDFLARE_TOKEN

}

variable "SUBSCRIPTION_ID" {
  type = string
}

variable "TENANT_ID" {
  type = string
}

variable "CLIENT_ID" {
  type = string
}

variable "CLIENT_SECRET" {
  type = string
}

variable "ENVIRONMENT" {
  type = string
}

variable "CLOUDFLARE_TOKEN" {
  type = string
}

variable "CLOUDFLARE_ZONE_ID" {
  type = string

}

variable "ROOT_DOMAIN_NAME" {
  type = string
}

variable "LETSENCRYPT_EMAIL_ADDRESS" {
  type = string
}

variable "PROJECT_COMMON_NAME" {
  type    = string
  default = "internaldomaincerts"
}
