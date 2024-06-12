# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

resource "aws_identitystore_group" "this" {
  display_name      = var.group_name
  description       = var.group_description
  identity_store_id = var.store_id
}

data "aws_identitystore_user" "this" {
  for_each          = var.group_membership
  identity_store_id = var.store_id

  alternate_identifier {
    unique_attribute {
      attribute_path  = "UserName"
      attribute_value = each.value
    }
  }
}

resource "aws_identitystore_group_membership" "this" {
  for_each          = var.group_membership
  identity_store_id = var.store_id
  group_id          = aws_identitystore_group.this.group_id
  member_id         = data.aws_identitystore_user.this[each.value].user_id
}
