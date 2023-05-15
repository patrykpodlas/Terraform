resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
  for_each         = { for user in var.users : user.user_principal_name => user }
}

resource "azuread_user" "user" {
  for_each            = { for user in var.users : user.user_principal_name => user }
  user_principal_name = each.value.user_principal_name
  display_name        = each.value.display_name
  password            = random_password.password[each.key].result
}
