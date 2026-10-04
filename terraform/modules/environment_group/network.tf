###############################################################################
#  MODULE environment_group — VNet, Subnets, NSG and security rules
###############################################################################

# ─── Virtual Network ──────────────────────────────────────────────────────────

resource "azurerm_virtual_network" "main" {
  name                = var.vnet_name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  address_space       = var.vnet_address_space
  tags                = var.tags
}

# ─── VM Subnet ────────────────────────────────────────────────────────────────

resource "azurerm_subnet" "compute" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = var.subnet_address_prefixes
}

# ─── Private Endpoint Subnet ──────────────────────────────────────────────────

resource "azurerm_subnet" "private_endpoint" {
  name                              = var.subnet_pe_name
  resource_group_name               = azurerm_resource_group.main.name
  virtual_network_name              = azurerm_virtual_network.main.name
  address_prefixes                  = var.subnet_pe_address_prefixes
  private_endpoint_network_policies = "Enabled"
}

# ─── Network Security Group ───────────────────────────────────────────────────

resource "azurerm_network_security_group" "main" {
  name                = var.nsg_name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  tags                = var.tags

  # Rule 1: ALLOW Azure Bastion Developer (Azure magic IP)
  security_rule {
    name                       = "AllowAzureBastionDeveloper"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    description                = "Allow SSH from Azure Bastion Developer"
  }

  # Rule 2: DENY all inbound Internet traffic
  security_rule {
    name                       = "DenyAllInboundInternet"
    priority                   = 4096
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
    description                = "Block all inbound Internet traffic"
  }
}

# ─── Associate NSG to VM Subnet ───────────────────────────────────────────────

resource "azurerm_subnet_network_security_group_association" "compute" {
  subnet_id                 = azurerm_subnet.compute.id
  network_security_group_id = azurerm_network_security_group.main.id
}
