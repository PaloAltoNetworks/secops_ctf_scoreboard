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

## Initialize Terraform

- Now do `cd aws` and type `terraform init` to get started.
- You should see a message as below

```
Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.
```
