module "kv-ppodlas-example" {
  source         = "../../../modules/azure-key-vault"
  rg_name        = "rg-ppodlas-example"
  key_vault_name = "kv-ppodlas-example"
}
