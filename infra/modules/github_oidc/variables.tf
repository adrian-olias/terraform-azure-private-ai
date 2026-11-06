variable "name" {
  description = "Entra ID application name."
  type        = string
}

variable "repository" {
  description = "GitHub repository allowed to log in, as <owner>/<repo>."
  type        = string

  validation {
    condition     = can(regex("^[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+$", var.repository))
    error_message = "repository must be <owner>/<repo>."
  }
}

variable "branch" {
  description = "Branch allowed to log in."
  type        = string
  default     = "main"
}

variable "owners" {
  description = "Object IDs of the application owners."
  type        = list(string)
}
