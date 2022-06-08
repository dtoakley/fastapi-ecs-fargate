# Pre-requisites

- Ensure the Terraform state bucket is created, as specified in `terraform.tf`

# How to use 

Initialize the Terraform backend:

```shell
$ terraform init
```

Using your default/admin AWS env variables, create the AWS user and user policy that will be used to execute terraform commands
going forward:

```shell
$ terraform apply --auto-approve -target=aws_iam_user.fastapi-terraform -target=aws_iam_user_policy.fastapi-terraform-policy
```

After doing this, manually create a secret access key for this user, and store that securely in a secret manager. You
could create the key via terraform as well, however that introduces a risk that the secrets may be stored in the 
Terraform state file. 

This access key id and secret access key can then be used as AWS environment variables to execute Terraform: 

- `terraform plan`
- `terraform apply`
