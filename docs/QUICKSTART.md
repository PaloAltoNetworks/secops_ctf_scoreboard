# QUICKSTART

- Run the "config" script in this repo. 
- Correct the errors until you get output as below.

```

franklin@reticulum ~ 🔬  bash ./config.sh 

***** Do the Setup for Mac *****
/usr/local/bin/brew
Already up-to-date.
/usr/local/bin/terraform
Found terraform
/usr/local/bin/aws
***** Mac Setup Complete *****
***** Confirm AWS Configuration *****

aws-cli/2.0.5 Python/3.8.2 Darwin/18.7.0 botocore/2.0.0dev9
AWS Configuration looking good...
***** Check  for terraform.tfvars file *****

Found tfvars file in /Users/fdiaz/workspace/ctf_scoreboard/terraform/aws/terraform.tfvars


No errors. All clean and green.
```

## Subscribe to Firewall AMi

- [Navigate to this link](https://aws.amazon.com/marketplace/pp?sku=6njl1pau431dv1qxipg63mvah)
- Accept the terms
- Configuration:
  - Fullfillment option: 64-bit AMI
  - Software Version: PAN-OS 9.0.6 (Nov 30th, 2019)
  - Region: US West Oregon
  - Verify the Ami Id: ami-09caf56db45f96bca

## Initialize Terraform

- You should use v12 (not v11)
- Now do `cd aws` and type `terraform init` to get started.
- You should see a message as below

```
Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.
```

