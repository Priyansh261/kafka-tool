variable "vpc_id" {}
variable "peer_vpc_id" {}
variable "route_table_ids" { type = list(string) }
variable "ansible_vpc_cidr" {}
variable "ansible_route_table_id" {}
variable "vpc_cidr" {}
