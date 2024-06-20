# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

locals {
  groups_yaml = var.groups != null ? file(var.groups) : ""
  groups_list = local.groups_yaml != "" ? yamldecode(local.groups_yaml) : {}

  groups_flatten = flatten([
    for group_name, group_details in local.groups_list : [
      for user in group_details.users :
      {
        user  = user
        group = group_name
      }
    ]
  ])

  users_yaml = var.users != null ? file(var.users) : ""
  users_list = local.users_yaml != "" ? yamldecode(local.users_yaml) : {}
}