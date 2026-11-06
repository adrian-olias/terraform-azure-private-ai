resource "azurerm_network_security_group" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  dynamic "security_rule" {
    for_each = var.inbound_rules

    content {
      name                       = security_rule.key
      priority                   = security_rule.value.priority
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_port_range     = security_rule.value.destination_port_range
      destination_address_prefix = security_rule.value.destination_address_prefix
    }
  }

  security_rule {
    name                       = "DenyAllInbound"
    priority                   = var.deny_all_inbound_priority
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    source_address_prefix      = "*"
    destination_port_range     = "*"
    destination_address_prefix = "*"
  }

  # Allow rules must have a lower priority number than the deny-all rule, or they would never apply
  lifecycle {
    precondition {
      condition     = alltrue([for rule in values(var.inbound_rules) : rule.priority < var.deny_all_inbound_priority])
      error_message = "Every inbound rule priority must be lower than deny_all_inbound_priority."
    }
  }
}
