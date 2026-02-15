# ---------------- VPC ----------------
output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "public_subnets" {
  description = "Public subnet IDs"
  value       = module.vpc.public_subnet_ids
}

output "private_subnets" {
  description = "Private subnet IDs"
  value       = module.vpc.private_subnet_ids
}

# ---------------- Security Groups ----------------
output "bastion_sg_id" {
  description = "Security Group ID for Bastion"
  value       = module.security.bastion_sg_id
}

output "kafka_sg_id" {
  description = "Security Group ID for Kafka Instances"
  value       = module.security.kafka_sg_id
}

# ---------------- EC2 Instances ----------------
output "bastion_instance_id" {
  description = "Bastion Host Instance ID"
  value       = module.ec2.bastion_instance_id
}

output "kafka_instance_ids" {
  description = "Kafka EC2 Instance IDs"
  value       = module.ec2.kafka_instance_ids
}

# ---------------- Peering ----------------
output "vpc_peering_id" {
  description = "VPC Peering Connection ID"
  value       = module.peering.peering_id
}
