locals{
  app_service_plan_id        = join("", tolist([for v in azurerm_app_service_plan.web_app_service_plan : v.id]))
}