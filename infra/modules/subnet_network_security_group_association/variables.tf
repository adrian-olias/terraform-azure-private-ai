variable "subnet_id" {
  description = "Subnet to protect."
  type        = string
}

variable "network_security_group_id" {
  description = "Network security group applied to the subnet."
  type        = string
}
