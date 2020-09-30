=============
NEW SSO SETUP
=============

The easiest path to a secure AWS account is to terminate your 
account and request a new pan-lab account via JIRA at: 
`https://jira-hq.paloaltonetworks.local/projects/INFRSC`_.

.. _`https://jira-hq.paloaltonetworks.local/projects/INFRSC`: https://jira-hq.paloaltonetworks.local/projects/INFRSC

All new requests for an AWS account come with pre-baked security
controls such as Okta Universal by default.

Just select the "AWS - New Account" issue type; you will need 
the following information to complete the ticket and request:

- Business Unit (this can be found in Workday under My Team > Organizations I Belong To)
- Cost Center (same as above)
- Environment (Dev, Stage, or Prod.  Most will choose Dev)
- Admin Email (the email you will use to admin your account, typically your @panw account)
- IAM Roles (for single user accounts, create a google doc with “admin” in the body and link that; for accounts with multiple users/roles, please create a google doc and document these and link in the ticket)

`Here is an example`_. of how to populate your ticket.

.. _`Here is an example`: https://jira-hq.paloaltonetworks.local/browse/INFRSC-753

Next, navigate to `the log-in portal.`_.

.. _`the log-in portal.`: https://pan-lab.awsapps.com/start#/

Finally, click on "Command line or programmatic access" and copy/paste
the credentials into your shell.
