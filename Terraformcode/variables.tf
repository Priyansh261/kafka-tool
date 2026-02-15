variable "region" {}
variable "vpc_cidr" {}
variable "public_subnets" { type = list(string) }
variable "private_subnets" { type = list(string) }
variable "instance_type" {}
variable "key_name" {}
variable "ansible_vpc_id" {}
variable "ansible_vpc_cidr" {}
variable "ansible_route_table_id" {}
