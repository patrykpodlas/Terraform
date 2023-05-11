locals {
  vm_annotation_terraform_workspace = "Terraform workspace/Application/Service: ${terraform.workspace}"
  vm_annotation_build_date          = formatdate("YYYY-MM-DD hh:mm ZZZ", timestamp())
  vm_annotation                     = "${local.vm_annotation_terraform_workspace}\nBuilt on: ${local.vm_annotation_build_date}"
}
