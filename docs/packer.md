# Packer

## Validate

Run the command `packer validate scoreboard.json`

## Build

- Run `packer build scoreboard.json` to build

## Remove

- Avoid charges to AWS account

- Remove the AMI by first deregistering it on the AWS AMI management page. 
  - https://console.aws.amazon.com/ec2/v2/home?region=us-east-1#Images:sort=name
- Next, delete the associated snapshot on the AWS snapshot management page.
