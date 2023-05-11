module "kv-ppodlas-example" {
  source         = "../../../modules/azure-key-vault"
  rg_name        = "rg-ppodlas-example"
  key_vault_name = "kv-ppodlas-example"
}

module "kv-secret-env-terra-vcenter-username" {
  source            = "../../../modules/azure-key-vault-secrets"
  key_vault_name    = module.kv-ppodlas-example.key-vault-name
  key_vault_rg_name = module.kv-ppodlas-example.rg-name
  secret_name       = "env-terra-vcenter-username"
  secret_value      = "SuperSecretUsername"
}

module "kv-secret-env-terra-vcenter-password" {
  source            = "../../../modules/azure-key-vault-secrets"
  key_vault_name    = module.kv-ppodlas-example.key-vault-name
  key_vault_rg_name = module.kv-ppodlas-example.rg-name
  secret_name       = "env-terra-vcenter-password"
  secret_value      = "SuperSecretPassword"
}

module "kv-secret-env-terra-da-username" {
  source            = "../../../modules/azure-key-vault-secrets"
  key_vault_name    = module.kv-ppodlas-example.key-vault-name
  key_vault_rg_name = module.kv-ppodlas-example.rg-name
  secret_name       = "env-terra-da-username"
  secret_value      = "SuperSecretUsername"
}

module "kv-secret-env-terra-da-password" {
  source            = "../../../modules/azure-key-vault-secrets"
  key_vault_name    = module.kv-ppodlas-example.key-vault-name
  key_vault_rg_name = module.kv-ppodlas-example.rg-name
  secret_name       = "env-terra-da-password"
  secret_value      = "SuperSecretPassword"
}

module "kv-secret-env-terra-communicator-username" {
  source            = "../../../modules/azure-key-vault-secrets"
  key_vault_name    = module.kv-ppodlas-example.key-vault-name
  key_vault_rg_name = module.kv-ppodlas-example.rg-name
  secret_name       = "env-terra-communicator-username"
  secret_value      = "SuperSecretUsername"
}

module "kv-secret-env-terra-communicator-password" {
  source            = "../../../modules/azure-key-vault-secrets"
  key_vault_name    = module.kv-ppodlas-example.key-vault-name
  key_vault_rg_name = module.kv-ppodlas-example.rg-name
  secret_name       = "env-terra-communicator-password"
  secret_value      = "SuperSecretPassword"
}
