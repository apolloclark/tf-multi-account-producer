# tf-multi-account-producer
Demo for TFC / TFE to perform a single TF Run against multiple Cloud Accounts.

THIS DEMO SHOULD BE USED WITH CAUTION, SINCE IT COULD BE USED IN AN INSECURE
WAY THAT WOULD PUBLISH ALL OF YOUR CLOUD CREDENTIALS.

The flow is:
- USE TF 0.15.0 AND NEWER!!!
- set your Github Owner (username) and Github Token
- set a HCL2 Variable map of all of your Cloud Providers, with Cloud Accounts
- run this HCL2 code, either locally or within a TFE / TFC Workspace
- this will render a template called "providers.tf"
- the "providers.tf" file will then be send with "git commit" to a Github Enterprise git repo
- the secondary Github Enterprise git repo can now perform operations across multiple cloud accounts



```shell
# create a Git Repo called "tf-multi-account-consumer", or set your own by defining
# an HCL2 Variable called "git_repo_consumer_name"

# configure a Github OAuth Token, as Environment Variables, preferably in "~/.bashrc"
# https://registry.terraform.io/providers/integrations/github/latest/docs#token
# https://github.com/settings/tokens
export GITHUB_OWNER="<your_github_username>"
export GITHUB_TOKEN="<github_oauth_token>"

# test your Github OAuth Token is set correctly
# you should see the output "HTTP/2 200"
curl -s -I -u ${GITHUB_OWNER}:${GITHUB_TOKEN} https://api.github.com/user | grep "HTTP/2 200"



# Run locally
terraform init
terraform validate -var-file=terraform.tfvars
terraform plan -var-file=terraform.tfvars
terraform apply -auto-approve -var-file=terraform.tfvars



# Run within TFE / TFC
# Create a TF Workspace, setup a VCS connection to this Git Repo
# configure a TF Workspace Environment Variable called "GITHUB_OWNER"
# configure a TF Workspace Environment Variable called "GITHUB_TOKEN"
# configure a TF Workspace Variable called "cloud_providers"

# https://www.terraform.io/docs/cloud/workspaces/variables.html
# https://www.terraform.io/docs/cli/config/environment-variables.html
# https://www.terraform.io/docs/cloud/api/workspace-variables.html

# perform a TF Run
```
