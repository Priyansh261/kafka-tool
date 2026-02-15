module "vpc" {
  source          = "./modules/vpc"
  vpc_cidr        = var.vpc_cidr
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets
}

module "security" {
  source            = "./modules/security"
  vpc_id            = module.vpc.vpc_id
  ansible_vpc_cidr  = var.ansible_vpc_cidr
  vpc_cidr          = var.vpc_cidr
}


module "ec2" {
  source                = "./modules/ec2"
  private_subnet_ids    = module.vpc.private_subnet_ids
  public_subnet_id      = module.vpc.public_subnet_ids[0]
  kafka_sg_id           = module.security.kafka_sg_id
  bastion_sg_id         = module.security.bastion_sg_id
  instance_type         = var.instance_type
  key_name              = var.key_name
}

module "peering" {
  source                 = "./modules/peering"
  vpc_id                 = module.vpc.vpc_id
  peer_vpc_id            = var.ansible_vpc_id
  route_table_ids        = module.vpc.private_route_table_ids
  ansible_vpc_cidr       = var.ansible_vpc_cidr
  ansible_route_table_id = var.ansible_route_table_id
  vpc_cidr               = var.vpc_cidr
}
