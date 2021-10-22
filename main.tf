terraform {
  required_version = ">=0.12.0"
} 

provider "azurerm" {
  features {}
    subscription_id = "ef59769b-58ba-4e31-aab6-9d1292135695"
    client_id       = "f8e4749e-67e2-48b3-9c22-c08481e51fc4"
    client_secret   = "7f46afbc-8691-493a-8627-e5e4d5d05cd9"
    tenant_id       = "45830bb8-b480-474b-a756-34f84e193c73"
}


module "module_for_RG_vnet_and_subnet" {
    source              = "./terraformkata1/module"
    resource_group_name = var.resource_group_name
    location            = var.location
    vnet_name           = var.vnet_name
    address_space       = var.address_space
    subnet              = var.subnet

}

module "webapp" {
  source               = "./webapp/module"
  resource_group_name  = data.azurerm_resource_group.kata1ResourceGroup.name
  location             = data.azurerm_resource_group.kata1ResourceGroup.location
  application_insights = var.application_insights
  web_app_properties   = var.web_app_properties
  app_service_plan     = var.app_service_plan
  is_container         = var.is_container
}

resource "azurerm_frontdoor" "frontdoorkata" {
    name                                         = "frontdoorkata111"
    resource_group_name                          = data.azurerm_resource_group.kata1ResourceGroup.name
    enforce_backend_pools_certificate_name_check = true

    routing_rule {
    name               = "routingrule"
    accepted_protocols = ["Http", "Https"]
    patterns_to_match  = ["/*"]
    frontend_endpoints = ["frontdoorkata111"]
    forwarding_configuration {
      forwarding_protocol = "MatchRequest"
      backend_pool_name   = "backendMicrosoftDocs"
     }
    }

    backend_pool_load_balancing {
    name = "loadbalancingsettings"
    }

    backend_pool_health_probe {
    name    = "healthprobesettings"
    enabled = false
    probe_method = "HEAD"
    }

    backend_pool {
    name = "backendMicrosoftDocs"
    backend {
        host_header = "www.docs.microsoft.com"
        address     = "www.docs.microsoft.com"
        http_port   = 80
        https_port  = 443
    }
    load_balancing_name = "loadbalancingsettings"
    health_probe_name   = "healthprobesettings"
    }

    frontend_endpoint {
    name      = "frontdoorkata111"
    host_name = "frontdoorkata111.azurefd.net"
    session_affinity_enabled = false
    session_affinity_ttl_seconds = 0
    }
}