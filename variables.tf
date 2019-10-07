
variable "name" {
  type = string
}

variable "count_node_vm" {
  type = number
}

variable "count_master_vm" {
  type = number
}

variable "project" {
  type = string
}
variable "region" {
  type = string
}

variable "zone" {
  type = string
}

variable "machine_type" {
  type = string
}

variable "centos_image" {
  type = string
}

variable "firewall_rules" {
  type = map(list(string))
}
variable "meta_info" {
  type = map
}
