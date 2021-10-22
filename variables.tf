
variable "location" {
    default = "Uk South"
}

## terraformkata1 variables ------------------------------------------------

variable "resource_group_name" {
    default = "terraformKata01"
}

variable "vnet_name" {
    default = "example-vnet"
}

variable "address_space" {
    default = ["10.0.0.0/16"]
}

variable "subnet" {
    default = {
        subnet1 = {
            name = "subnet1"
            prefix = ["10.0.1.0/24"]
        }
        subnet2 = {
            name = "subnet2"
            prefix = ["10.0.2.0/24"]
        }
        subnet3 = {
            name = "subnet3"
            prefix = ["10.0.3.0/24"]
        }
    }    
}    


## webapp variables ---------------------------------------------------------

variable "is_container" {
  description = "Boolean flag indicating if it is a webapp for container or webapp"
  type        = bool
  default     = true
}

variable "application_insights" {
  description = "application insights resource properties, if no existing application insights instance is specified"
  default = {
    application_insights_1 = {
      name                                  = "kata1appinsights"
      application_type                      = "web"
      daily_data_cap_in_gb                  = 1
      retention_in_days                     = 60
      disable_ip_masking                    = "true"
      daily_data_cap_notifications_disabled = "true"
      tags = {
        Environment        = "dev"
        ManagedbyTerraform = "True"
      }
    }
  }
}

variable "application_insights_instrumentation_key" {
  description = "Application Insights instrumentation key for web app container logs, generated if empty"
  type        = string
  default     = ""
}

variable "web_app_properties" {
  description = "Web App Properties"
  default = {
    web_app_1 = {
      name                    = "kata1webapp1"
      client_affinity_enabled = "false"
      client_cert_enabled     = "false"
      https_only              = "true"

      site_config = {
        always_on                   = "true"
        use_32_bit_worker_process   = "true"
        min_tls_version             = 1.2
        cors_allowed_origins        = []
        cors_support_credentials    = "false"
        scm_use_main_ip_restriction = "true"
      }

      tags = {
        Environment        = "dev"
      }
    }
  }
}

/*variable "web_app_slot_properties" {
  description = "Web App slot Properties"
  default = {
  }
}*/

variable "app_service_plan" {
  description = "App Service Plan"
  default = {
    app_service_plan_1 = {
      name    = "kata1appserviceplan"
      os_type = "Linux"
      sku = {
        tier = "Standard"
        size = "S1"
      }
      per_site_scaling = false
      tags = {
        Environment        = "dev"
        ManagedbyTerraform = "True"
      }
    }
  }
}

