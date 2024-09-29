resource "azurerm_resource_group" "resource-group" {
  name     = "${var.PROJECT_COMMON_NAME}-rg-${var.ENVIRONMENT}"
  location = "westus2"
}