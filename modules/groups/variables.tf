# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: MIT-0

variable "group_name" {
  type = string
}

variable "group_description" {
  type = string
}

variable "group_membership" {
  type = set(string)
}

variable "store_id" {
  type = string
}
