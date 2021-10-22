


# App Service Plan
resource "azurerm_app_service_plan" "web_app_service_plan" {
  for_each            = var.app_service_plan
  name                = each.value.name
  location            = var.location
  resource_group_name = var.resource_group_name

  tags             = each.value.tags

  sku {
    tier = each.value.sku.tier
    size = each.value.sku.size
  }
}

# # Data App Service Plan
# data "azurerm_app_service_plan" "plan" {
#   name                = local.app_service_plan_name
#   resource_group_name = length(var.app_service_plan) == 0 ? var.app_service_plan_rg_name : var.resource_group_name

#   depends_on = [azurerm_app_service_plan.web_app_service_plan]
# }

# Application Insights
resource "azurerm_application_insights" "app_insights" {
  for_each = var.application_insights

  name                = each.value.name
  location            = var.location
  resource_group_name = var.resource_group_name

  application_type                      = each.value.application_type
  daily_data_cap_in_gb                  = each.value.daily_data_cap_in_gb
  retention_in_days                     = each.value.retention_in_days
  disable_ip_masking                    = each.value.disable_ip_masking
  daily_data_cap_notifications_disabled = each.value.daily_data_cap_notifications_disabled

  tags = each.value.tags

  depends_on = [azurerm_app_service_plan.web_app_service_plan]
}

resource "azurerm_app_service" "web_app" {
  for_each = var.web_app_properties

  name                    = each.value.name
  app_service_plan_id     = local.app_service_plan_id
  location                = var.location
  resource_group_name     = var.resource_group_name
  client_affinity_enabled = each.value.client_affinity_enabled
  client_cert_enabled     = each.value.client_cert_enabled
  https_only              = each.value.https_only
  site_config {

    min_tls_version           = each.value.site_config.min_tls_version
    cors {
      allowed_origins     = each.value.site_config.cors_allowed_origins
      support_credentials = each.value.site_config.cors_support_credentials
    }
    scm_use_main_ip_restriction = each.value.site_config.scm_use_main_ip_restriction
  }

  tags = each.value.tags
}