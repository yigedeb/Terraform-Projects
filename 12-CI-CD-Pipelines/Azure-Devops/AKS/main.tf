terraform {
  backend "azurerm" {
    resource_group_name = "yig-rg"
    storage_account_name = "yigtfstate"
    container_name = "tfstate"
    key = "terraform.state"
  }
}

provider azurerm {
   version = "=2.20.0"
  features {}
}

resource "azurerm_kubernetes_cluster" "CloudSkillsAKS" {
  name                = var.Name
  location            = var.location
  resource_group_name = var.resourceGroup
  dns_prefix          = "dnsyigaksprefix"

  default_node_pool {
    name = "default"
    node_count = 1
    vm_size = "Standard_D2s_v3"
  }
  service_principal {
    client_id     = var.clientID
    client_secret = var.clientSecret
  }

  tags = {
    Environment = "Development"
  }
}
