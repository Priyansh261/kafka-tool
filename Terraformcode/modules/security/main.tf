# ---------------- Bastion Security Group ----------------
resource "aws_security_group" "bastion" {
  name        = "bastion-sg"
  description = "Security group for Bastion host"
  vpc_id      = var.vpc_id

  # SSH from anywhere (public access)
  ingress {
    description = "SSH from Internet"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Bastion can reach private instances
  egress {
    description = "Access to private subnet"
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  # Internet access
  egress {
    description = "Internet access"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "bastion-sg"
  }
}

# ---------------- Kafka / Private Instance Security Group ----------------
resource "aws_security_group" "kafka" {
  name        = "kafka-sg"
  description = "Security group for Kafka private instances"
  vpc_id      = var.vpc_id

  # Kafka cluster internal communication
  ingress {
    description = "Kafka inter-broker communication"
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    self        = true
  }

  # SSH from Bastion host
  ingress {
    description     = "SSH from Bastion"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion.id]
  }

  # SSH from Peered VPC
  ingress {
    description = "SSH from Peered VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ansible_vpc_cidr]
  }

  # Kafka port from Peered VPC
  ingress {
    description = "Kafka traffic from Peered VPC"
    from_port   = 9092
    to_port     = 9092
    protocol    = "tcp"
    cidr_blocks = [var.ansible_vpc_cidr]
  }

  egress {
    description = "Outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "kafka-sg"
  }
}
