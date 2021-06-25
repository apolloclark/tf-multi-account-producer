# Templatefile for Terraform to render HCL2 code with multiple cloud providers

%{ for provider, accounts in cloud_providers ~}
%{ for account in accounts ~}
provider "${provider}" {
%{ for arg, val in account ~}
  ${arg} = "${val}"
%{ endfor ~}
}
%{ endfor ~}
%{ endfor ~}
