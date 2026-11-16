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

variable "owner_id" {
  description = "Numeric GitHub ID of the repository owner. GitHub puts it in the token subject: repo:<owner>@<owner_id>/<repo>@<repository_id>:..."
  type        = string

  validation {
    condition     = can(regex("^[0-9]+$", var.owner_id))
    error_message = "owner_id must be the numeric GitHub ID."
  }
}

variable "repository_id" {
  description = "Numeric GitHub ID of the repository. See owner_id."
  type        = string

  validation {
    condition     = can(regex("^[0-9]+$", var.repository_id))
    error_message = "repository_id must be the numeric GitHub ID."
  }
}

variable "subjects" {
  description = "Workflow contexts allowed to log in, by credential name. Each value is the part after the repository in the subject, e.g. pull_request, environment:Production or ref:refs/heads/main."
  type        = map(string)

  validation {
    condition     = length(var.subjects) > 0 && alltrue([for s in values(var.subjects) : can(regex("^(pull_request|environment:.+|ref:refs/(heads|tags)/.+)$", s))])
    error_message = "subjects needs at least one entry, each pull_request, environment:<name> or ref:refs/heads|tags/<name>."
  }
}

variable "owners" {
  description = "Object IDs of the application owners."
  type        = list(string)
}
