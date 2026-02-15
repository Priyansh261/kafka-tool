output "kafka_instance_ids" { value = aws_instance.kafka[*].id }
output "bastion_instance_id" { value = aws_instance.bastion.id }
