output "user_passwords" {
  value = {
    for k, v in random_password.password : k => v.result
  }
  sensitive = true
}
