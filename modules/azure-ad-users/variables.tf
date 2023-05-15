variable "users" {
  description = "List of users to create"
  type = list(object({
    user_principal_name = string
    display_name        = string
  }))
}
