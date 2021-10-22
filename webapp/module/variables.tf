variable "app_service_plan_id" {
  description = "Id of the App Service Plan for Function App hosting"
  type        = string
  default     = ""
}
variable "app_service_plan_rg_name" {
  description = "Resource Group name of the App Service Plan"
  type        = string
  default     = ""
}

variable "is_container" {
  description = "Boolean flag indicating if it is a webapp for container or webapp"
  type        = bool
  default     = false
}

variable "location" {
  description = "Location where the webapp app will be deployed"
  type        = string
  default     = "UKSouth"
}

variable "resource_group_name" {
  description = "Resource group name "
  type        = string
  default     = ""
}

variable "application_insights" {
  description = "application insights resource properties, if no existing application insights instance is specified"
  default = {
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
  }
}