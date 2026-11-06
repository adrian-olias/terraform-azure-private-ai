variable "name" {
  description = "Network security group name."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group for the network security group."
  type        = string
}

variable "location" {
  description = "Azure region."
  type        = string
}

variable "inbound_rules" {
  description = "Inbound allow rules by name. Everything else inbound is denied."
  type = map(object({
    priority                   = number
    source_address_prefix      = string
    destination_port_range     = string
    protocol                   = optional(string, "Tcp")
    source_port_range          = optional(string, "*")
    destination_address_prefix = optional(string, "*")
  }))
  default = {}

  validation {
    condition     = alltrue([for rule in values(var.inbound_rules) : rule.priority >= 100 && rule.priority <= 4094])
    error_message = "Priorities must be between 100 and 4094."
  }

  validation {
    condition     = alltrue([for rule in values(var.inbound_rules) : contains(["Tcp", "Udp", "Icmp", "*"], rule.protocol)])
    error_message = "protocol must be Tcp, Udp, Icmp or *."
  }
}

variable "tags" {
  description = "Tags for the network security group."
  type        = map(string)
  default     = {}
}

variable "deny_all_inbound_priority" {
  description = "Priority of the rule that denies all other inbound traffic. Allow rules must be lower."
  type        = number
}
