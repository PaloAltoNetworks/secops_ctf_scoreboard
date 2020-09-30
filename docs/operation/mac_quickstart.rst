==============
MAC QUICKSTART
==============

  Do these steps to get your local machine ready. Be sure to
  enable MFA on your Amazon AWS account.

Prepare your local environment
------------------------------

  Follow the steps in new_sso document.

Key Management
--------------

- Use existing or [create an SSH key pair](https://aws.amazon.com/premiumsupport/knowledge-center/ec2-ssh-key-pair-regions/)
  - Do not share the private half of your key, ever.
- In the file `scoreboard/variables.tf` update the value of public_key.

Initialize Terraform
--------------------

- Do `cd scoreboard` and then `terraform init` to get started.
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

  SSH into the scoreboard instance and set up the application like so:

.. code-block:: bash

  ssh -i "id_rsa" ubuntu@ec2-18-221-39-211.us-east-2.compute.amazonaws.com
  # configure python and docker
  sudo /home/ubuntu/ctf_scoreboard/packer/ctfd_setup.sh

 Now you can navigate to port 8000 on the AWS instance with your browser.

Teardown
--------

  To save money on unused instances, we can use the command 
  `terraform destroy` to tear everything completely down.
