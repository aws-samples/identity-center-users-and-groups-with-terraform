# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

data "aws_ssoadmin_instances" "this" {}

module "groups" {
  source            = "./modules/groups"
  for_each          = local.groups_list
  group_name        = each.key
  group_description = each.value.description
  group_membership  = toset(each.value.users)
  store_id          = tolist(data.aws_ssoadmin_instances.this.identity_store_ids)[0]
  depends_on = [ aws_identitystore_user.this ]
}

resource "aws_identitystore_user" "this" {
  for_each = local.users_list
  identity_store_id = tolist(data.aws_ssoadmin_instances.this.identity_store_ids)[0]

  display_name = each.value.first_name
  user_name    = each.key

  name {
    given_name  = each.value.first_name
    family_name = each.value.last_name
  }

  emails {
    value = each.value.email
  }
}