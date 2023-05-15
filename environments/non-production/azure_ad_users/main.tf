module "create-azure-ad-users" {
  source = "../../../modules/azure-ad-users"
  users = [
    {
      user_principal_name = "user1@email.com" # Must be a UPN
      display_name        = "User One"
    },
    {
      user_principal_name = "user2@email.com" # Must be a UPN
      display_name        = "User Two"
    },
    {
      user_principal_name = "user3@email.com" # Must be a UPN
      display_name        = "User Three"
    },
    # add more users here
  ]
}

output "user_passwords" {
  description = "The passwords for the created users"
  value       = module.create-azure-ad-users.user_passwords
  sensitive   = true
}
