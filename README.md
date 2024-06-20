# identity-center-users-and-groups-with-terraform

Create AWS IAM Identity Center groups, users, and group membership with Terraform.

## Prerequisites

- [Enable Identity Center](https://docs.aws.amazon.com/singlesignon/latest/userguide/get-set-up-for-idc.html)

## Module Inputs
```hcl
module "idc_users_and_groups" {
  source = "github.com/aws-samples/identity-center-users-and-groups-with-terraform"
  groups = "./groups.yml"
  users  = "./users.yml"
  }
```
Groups, users, and group membership are defined using yaml templates. The module then handles the heavy lifting. 

Example [groups.yml](./examples/groups.yml) and [users.yml](./examples/users.yml) . 

## Permission sets and account assignments 

This pattern does not create permission sets and account assignments. If you want to do this, use this pattern: [idc-with-terraform](https://github.com/aws-samples/identity-center-with-terraform)

We have deliberately segregated the two patterns:

- You may be using an external IdP
- You may be planning to use an external IdP and want to build a pattern that can be de-coupled in the future
- At scale, any explicit or implicit dependencies (depends_on) between account assignments and group membership can have unintended consequences.
  - Example: with a dependency, adding a user to a group can cause terraform to refresh all account assignments that feature that group (into the 100s or 1000s depending on the scale of your AWS Organization).

## Related Resources 

- [AWS IAM Identity User Guide](https://docs.aws.amazon.com/singlesignon/latest/userguide/what-is.html)
- [Resource: aws_identitystore_use](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/identitystore_user)
- [Resource: aws_identitystore_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/identitystore_group)
- [Resource: aws_identitystore_group_membership](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/identitystore_group_membership)

## Security
See [CONTRIBUTING](./CONTRIBUTING.md) for more information.

## License
This library is licensed under the MIT-0 License. See the LICENSE file.
