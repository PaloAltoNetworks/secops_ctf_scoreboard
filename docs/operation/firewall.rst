==================
Firewall Licensing
==================

Firewall
--------

  The PA-300 FW has limited functionality without a license,
  but will still work well enough that folks can run the 
  Terraform successfully. This will cause some issues however.
  For example, no logs will be captured on the firewall.

Getting A License
-----------------

  You can get a 10 device auth code at the 
  `System Engineer Devices`_. site.

  .. _`System Engineer Devices`: https://adminsite.paloaltonetworks.com/N/sedevices/

  Next associate the auth code with your account: 
  ``https://support.paloaltonetworks.com/``

==================
Firewall Hardening
==================

Once the firewall is licensed, you can take additional steps to
harden the environment.

Firewall
--------

Gibson
------

Scoreboard
----------

`Use Dynamic Address Groups to Secure New EC2 Instances within the VPC`_. 
This will allow you to monitor `these EC2 instance attributes` from the 
firewall.

.. _`Use Dynamic Address Groups to Secure New EC2 Instances within the VPC`: https://docs.paloaltonetworks.com/vm-series/9-0/vm-series-deployment/set-up-the-vm-series-firewall-on-aws/use-case-use-dynamic-address-groups-to-secure-new-ec2-instances-within-the-vpc.html
.. _`these EC2 instance attributes`: https://docs.paloaltonetworks.com/vm-series/9-0/vm-series-deployment/set-up-the-vm-series-firewall-on-aws/list-of-attributes-monitored-on-the-aws-vpc.html#ida8ca7e78-50e1-47db-9a25-39f944619c97