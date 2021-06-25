#
# main.tf
#

/*
- https://alexharv074.github.io/2019/11/23/adventures-in-the-terraform-dsl-part-x-templates.html
- https://learn.hashicorp.com/tutorials/terraform/functions?in=terraform/configuration-language
- https://www.terraform.io/docs/language/functions/templatefile.html
- https://www.terraform.io/docs/language/functions/file.html
- https://registry.terraform.io/providers/hashicorp/template/latest/docs
- https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file

- https://www.terraform.io/docs/language/providers/configuration.html
- https://www.terraform.io/docs/language/functions/templatefile.html
- https://github.com/hashicorp/hcl2/blob/master/hcl/hclsyntax/spec.md#templates

# Github
- File:
- https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file
- Branch:
- https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch
- Repo:
- https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository

# Gitlab
- Project:
- https://registry.terraform.io/providers/gitlabhq/gitlab/latest/docs/resources/project

# BitBucket
- Repo:
- https://registry.terraform.io/providers/aeirola/bitbucket/latest/docs/resources/repository

# Azure DevOps
- Repo:
- https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/git_repository

HCL2 syntax:
- https://www.packer.io/guides/hcl
*/




# https://www.terraform.io/docs/language/values/outputs.html
# https://www.hashicorp.com/blog/terraform-0-14-adds-the-ability-to-redact-sensitive-values-in-console-output
output "template" {
  value = templatefile("${path.module}/providers.tpl", { cloud_providers = var.cloud_providers })
}




# write the rendered template to Github Enterprise Repo
# https://registry.terraform.io/providers/integrations/github/latest/docs

# Configure the GitHub Provider
# This demo requires setting the environment variable "GITHUB_TOKEN" and "GITHUB_OWNER"
# https://registry.terraform.io/providers/integrations/github/latest/docs#token
provider "github" {
}

# https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository
resource "github_repository" "git_repo" {
  name      = var.git_repo_consumer_name
  auto_init = true
}

# https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_file
resource "github_repository_file" "foo" {
  repository          = github_repository.git_repo.name
  branch              = "main"
  file                = "providers.tf"
  content             = templatefile("${path.module}/providers.tpl", { cloud_providers = var.cloud_providers })
  commit_message      = "Managed by Terraform"
  commit_author       = "Terraform User"
  commit_email        = "terraform@example.com"
  overwrite_on_create = true
}

