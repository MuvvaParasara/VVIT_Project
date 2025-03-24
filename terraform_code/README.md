# INFRASTRUCTURE CREATION

## Environment

- ⁠AWS is our primary environment
- ⁠Used the college provided Account for this project
- So far we are using the root credentials to log in to the console.
- ⁠TODO: Create IAM roles, groups and assign users for individual contributors

## Terraform usage

- ⁠We tried Terraform which is the Infrastructure as code (IAC)
- All the AWS resources are created using the Terraform code.
- ⁠For terraform to access AWS account, we created an IAM user named ⁠ `Terraform_User`
- Secret Key and Access Key from the IAM have been used in this code.

## Run book

### ⁠Initialize Terraform Project.
  - This ensures the latest aws modules are downloaded to the local

```
$ cd PROJECT
$ terraform init
```

### SSH Key for EC2 Instance

```
$ ssh-keygen -t rsa
```

### ⁠Create Infrastructure

```
$ terraform plan
$ terraform apply --auto-approve
```

### Delete Infrastructure

```
$ terraform destroy --auto-approve
```


## References

- ⁠https://registry.terraform.io/providers/hashicorp/aws/latest
- ⁠https://www.youtube.com/watch?v=eBW0MWOBwe0&pp=ygUWdGVycmFmb3JtIGVjMiBpbnN0YW5jZQ%3D%3D
- ⁠https://medium.com/@deepamathan/terraform-infrastructure-as-a-code-1dbf0f7ed3e1