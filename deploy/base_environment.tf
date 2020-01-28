provider "azurerm" {
}

resource "azurerm_resource_group" "rg" {
        name                            = "dacrook-streamcon-dev"
        location                        = "eastus"
}

resource "azurerm_container_registry" "acr" {
        name                            =       "streamcondev"
        resource_group_name             =       "${azurerm_resource_group.rg.name}"
        location                        =       "${azurerm_resource_group.rg.location}"
        sku                             =       "Premium"
        admin_enabled                   =       true
        georeplication_locations        =       ["West US", "West Europe"]        
}

resource "azurerm_sql_server" "app_db" {
        name                            =       "streamconappdbdev"
        version                         =       "12.0"
        resource_group_name             =       "${azurerm_resource_group.rg.name}"
        location                        =       "${azurerm_resource_group.rg.location}"
        administrator_login             =       "dacrook"
        administrator_login_password    =       "David!234567890"
}

resource "azurerm_app_service_plan" "app_plan" {
        name                            =       "streamconappplan"
        location                        =       "${azurerm_resource_group.rg.location}"
        resource_group_name             =       "${azurerm_resource_group.rg.name}"
        kind                            =       "Linux"
        reserved                        =       true
        sku {
                tier    =       "Standard"
                size    =       "S1"
        }
}

resource "azurerm_app_service" "app_apis" {
        name                            =       "streamconappapis"
        location                        =       "${azurerm_resource_group.rg.location}"
        resource_group_name             =       "${azurerm_resource_group.rg.name}"
        app_service_plan_id             =       "${azurerm_app_service_plan.app_plan.id}"

        site_config {
                linux_fx_version                =       "DOCKER|${azurerm_container_registry.acr.login_server}/streamconapis:latest"
                remote_debugging_enabled        =       true
                remote_debugging_version        =       "VS2017"
        }

        app_settings = {
                "app_db_user"                   =       "${azurerm_sql_server.app_db.administrator_login}"
                "app_db_pw"                     =       "${azurerm_sql_server.app_db.administrator_login_password}"
                "DOCKER_REGISTRY_SERVER_URL"    =       "${azurerm_container_registry.acr.login_server}"
                "DOCKER_REGISTRY_SERVER_USERNAME"=      "${azurerm_container_registry.acr.admin_username}"
                "DOCKER_REGISTRY_SERVER_PASSWORD"=      "${azurerm_container_registry.acr.admin_password}"
        }
}

resource "azurerm_app_service" "app_ui" {
        name                            =       "streamconappui"
        location                        =       "${azurerm_resource_group.rg.location}"
        resource_group_name             =       "${azurerm_resource_group.rg.name}"
        app_service_plan_id             =       "${azurerm_app_service_plan.app_plan.id}"

        site_config {
                linux_fx_version                =       "DOCKER|${azurerm_container_registry.acr.login_server}/streamconui:latest"
                remote_debugging_enabled        =       true
                remote_debugging_version        =       "VS2017"
        }

        app_settings = {
                "app_apis_endpoint"             =       "${azurerm_app_service.app_apis.default_site_hostname}"
                "DOCKER_REGISTRY_SERVER_URL"    =       "${azurerm_container_registry.acr.login_server}"
                "DOCKER_REGISTRY_SERVER_USERNAME"=      "${azurerm_container_registry.acr.admin_username}"
                "DOCKER_REGISTRY_SERVER_PASSWORD"=      "${azurerm_container_registry.acr.admin_password}"
        }
}


output "acr_login_server" {
        value = "${azurerm_container_registry.acr.login_server}"
}

output "acr_user_name" {
        sensitive = true
        value = "${azurerm_container_registry.acr.admin_username}"
}

output "acr_password" {
        sensitive = true
        value = "${azurerm_container_registry.acr.admin_password}"
}