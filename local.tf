# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

locals {
  groups_yaml = var.groups != null ? file(var.groups) : ""
  groups_list = local.groups_yaml != "" ? yamldecode(local.groups_yaml) : {}

  users_yaml = var.users != null ? file(var.users) : ""
  users_list = local.users_yaml != "" ? yamldecode(local.users_yaml) : {}
}