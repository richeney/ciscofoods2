provider "azurerm" {
  features {}
  version = "~> 2.29.0"
}

locals {
  rg_list = [
    "syy-az-networking-ntwrk-vwan-centralus-rg-01",
    "syy-az-networking-ntwrk-vwan-eastus2-rg-01",
    "syy-az-networking-ntwrk-vnet-centralus-rg-01",
    "syy-az-networking-ntwrk-vnet-centralus-rg-02",
    "syy-az-networking-ntwrk-vnet-centralus-rg-03",
    "syy-az-networking-ntwrk-vnet-centralus-rg-04",
    "syy-az-networking-ntwrk-vnet-eastus2-rg-01",
    "syy-az-networking-ntwrk-vnet-eastus2-rg-02",
    "syy-az-networking-mgmt-st-centralus-rg-01",
    "syy-az-networking-mgmt-st-eastus2-rg-01",
    "syy-az-networking-mgmt-la-centralus-rg-01",
    "syy-az-networking-mgmt-la-eastus2-rg-01",
    "syy-az-networking-mgmt-rsv-centralus-rg-01",
    "syy-az-networking-mgmt-rsv-eastus2-rg-01",
    "syy-az-sharedservices-ntwrk-vnet-centralus-rg-01",
    "syy-az-sharedservices-ntwrk-vnet-eastus2-rg-01",
    "syy-az-sharedservices-mgmt-st-centralus-rg-01",
    "syy-az-sharedservices-mgmt-st-eastus2-rg-01",
    "syy-az-sharedservices-mgmt-la-centralus-rg-01",
    "syy-az-sharedservices-mgmt-la-eastus2-rg-01",
    "syy-az-sharedservices-mgmt-rsv-centralus-rg-01",
    "syy-az-sharedservices-mgmt-rsv-eastus2-rg-01"
  ]

  rg = { for rg in local.rg_list :
    rg => {
      name         = rg
      subscription = split("-", rg)[2]
      team         = split("-", rg)[3]
      service_area = split("-", rg)[4]
      region       = split("-", rg)[5]
    }
  }
}

resource "azurerm_resource_group" "rg" {
  for_each = local.rg

  name     = each.key // could also be name = each.value.name
  location = each.value.region
  tags = {
    subscription = each.value.subscription
    team         = each.value.team
    service_area = each.value.service_area
  }
}

output "rg" {
  value = local.rg
}
