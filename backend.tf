terraform{
    backend "azurerm" {
        resource_group_name  = "kataStorage"
        storage_account_name = "katastorageterraform"
        container_name       = "katacontainer"
        key                  = "terraform1.tfstate"
       
        
        access_key = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
    }
}    