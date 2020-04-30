==============
MAC QUICKSTART
==============

Mac Quickstart
  Do these steps to get your local machine ready. Be sure to
  enable MFA on your Amazon AWS account.

Prepare your local environment.
  `Generate AWS credentials`_.

.. _`Generate AWS credentials`: https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html

Now place your AWS credentials in ~/.aws/credentials. 
For example:

.. code-block:: bash

  [default]
  aws_access_key_id=AXIAYZDDL9ZF3GPCGMEG
  aws_secret_access_key=brFz5pGbHN6ei6UHy0y0dXg0hWD0TVzFiMMbtPe


Create a file called /aws/terraform.tfvars.  For example:

.. code-block:: bash

  aws_access_key="AXIAYZDDL9ZF3GPCGMEG"
  aws_secret_key="brFz5pGbHN6ei6UHy0y0dXg0hWD0TVzFiMMbtPe"

Run the "config" script in this repo. Correct the errors until 
you get output as below.

.. code-block:: bash

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


Subscribe to Firewall AMI
-------------------------

- [Navigate to this link](https://aws.amazon.com/marketplace/pp?sku=6njl1pau431dv1qxipg63mvah)
- Accept the terms
- Configuration:
  - Fullfillment option: 64-bit AMI
  - Software Version: PAN-OS 9.0.6 (Nov 30th, 2019)
  - Region: US West Oregon
  - Verify the Ami Id: ami-09caf56db45f96bca

Key Management
--------------

- Use existing or [create an SSH key pair](https://aws.amazon.com/premiumsupport/knowledge-center/ec2-ssh-key-pair-regions/)
  - Do not share the private half of your key, ever.
- [Add the public half of your SSH key to your AWS account](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html#how-to-generate-your-own-key-and-import-it-to-aws).
  - Name it "scoreboard" to match the name Terraform is expecting.

Initialize Terraform
--------------------

- The `config.sh` script should have helpd you complete Terraform install by this point.
  - You should use version 0.12.x (not v11)
  - v0.12.x is not compatible with prisma scanners at this time.
- Do `cd aws` and then `terraform init` to get started.
- You should see a message as below

.. code-block:: bash

  Terraform has been successfully initialized!
  You may now begin working with Terraform. Try running "terraform plan" to see
  any changes that are required for your infrastructure. All Terraform commands
  should now work.

Execute Terraform
-----------------

  Finally, you can run `terraform apply`. For exmaple:

.. code-block:: bash

  terraform plan -out franklin.out
  terraform apply "franklin.out"
  rm ./franklin.out

Login
-----

  Once the Terraform scripts have executed successfully, you
  will see two IPv4 addresses output by Terraform. In your 
  browser, navigate to https://x.x.x.x/, where x.x.x.x is the 
  IPv4 value of "firewall_mgmt_public_ip". You can log in 
  with the credentials specified in the bootstrap.xml file.

  You can also SSH to the scoreboard as the ubuntu user
  using the public key that was set in `aws/variables.tf` file, 
  variable "public_key"


Teardown
--------

  If you don't tear down the environment, your credit card on
  file will be billed. Use the command `terraform destroy` to 
  tear everything completely down.
