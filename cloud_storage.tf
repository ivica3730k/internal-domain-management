resource "azurerm_storage_account" "storage-container" {
  name                     = "${var.PROJECT_COMMON_NAME}${var.ENVIRONMENT}"
  resource_group_name      = azurerm_resource_group.resource-group.name
  location                 = azurerm_resource_group.resource-group.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  blob_properties {
    cors_rule {
      allowed_headers = ["*"]
      allowed_methods = ["POST",
        "DELETE",
        "GET",
        "HEAD",
        "MERGE",
        "PUT",
        "OPTIONS",
        "PATCH",
      ]
      allowed_origins    = ["*"]
      exposed_headers    = ["*"]
      max_age_in_seconds = 86400
    }
  }
}

resource "azurerm_storage_container" "container" {
  name                 = "certificates"
  storage_account_name = azurerm_storage_account.storage-container.name
}
