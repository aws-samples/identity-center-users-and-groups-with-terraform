# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

data "aws_ssoadmin_instances" "this" {}

resource "aws_identitystore_user" "this" {
  for_each          = local.users_list
  identity_store_id = tolist(data.aws_ssoadmin_instances.this.identity_store_ids)[0]

  display_name = title("${each.value.first_name} ${each.value.last_name}")
  user_name    = each.key

  name {
    given_name  = title(each.value.first_name)
    family_name = title(each.value.last_name)
  }

  emails {
    value = lower(each.value.email)
  }
}

resource "aws_identitystore_group" "this" {
  for_each          = local.groups_list
  display_name      = title(each.key)
  description       = each.value.description
  identity_store_id = tolist(data.aws_ssoadmin_instances.this.identity_store_ids)[0]
}

resource "aws_identitystore_group_membership" "this" {
  for_each          = { for group in local.groups_flatten : "${group.group}-${group.user}" => group }
  identity_store_id = tolist(data.aws_ssoadmin_instances.this.identity_store_ids)[0]
  group_id          = aws_identitystore_group.this[each.value.group].group_id
  member_id         = aws_identitystore_user.this[each.value.user].user_id
}
