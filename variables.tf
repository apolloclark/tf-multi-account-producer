#
# variables.tf
#

# https://www.terraform.io/docs/language/values/variables.html
# https://www.terraform.io/docs/language/values/variables.html#arguments
# https://www.terraform.io/docs/language/expressions/type-constraints.html#conversion-of-complex-types
# https://www.terraform.io/docs/language/expressions/index.html

# https://www.terraform.io/docs/language/providers/configuration.html

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs#authentication
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs#argument-reference
# using "assume_role" is the best practice, since there are not any long-lived credentials

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs

# https://registry.terraform.io/providers/hashicorp/google/latest/docs



variable "git_repo_consumer_name" {
  type = string
  sensitive = false
  description = "(string) name of the git repo to push the providers.tf file to"
  default = "tf-multi-account-consumer"
}
variable "cloud_providers" {
  type = map(list(map(any)))
  sensitive = false
  description = "(map(list(map(any)))) of multiple cloud providers, with multiple accounts"
  default = {
    "aws" = [
      {
        alias = "aws-account-alpha"
        region = "us-east-1"
      },
      {
        alias = "aws-account-beta"
        region = "us-east-1"
      },
    ],
    "azure" = [
      {
        alias = "azure-account-alpha"
        region = ""
      },
      {
        alias = "azure-account-beta"
        region = ""
      },
    ]
    "gcp" = [
      {
        alias = "gcp-account-alpha"
        region = ""
      },
      {
        alias = "gcp-account-beta"
        region = ""
      },
    ]
  }
}
