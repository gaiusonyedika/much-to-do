resource "aws_security_group" "alb" {
  name        = "startuptech-alb-sg"
  description = "ALB - HTTP from internet"
  vpc_id      = aws_vpc.main.id
  ingress {
    description = "HTTP from internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = { Name = "startuptech-alb-sg" }
}
resource "aws_security_group" "bastion" {
  name        = "startuptech-bastion-sg"
  description = "Bastion - SSH from my IP only"
  vpc_id      = aws_vpc.main.id
  ingress {
    description = "SSH from my IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ssh_cidr]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = { Name = "startuptech-bastion-sg" }
}
resource "aws_security_group" "backend" {
  name        = "startuptech-backend-sg"
  description = "Backend - 8080 from ALB, SSH from Bastion"
  vpc_id      = aws_vpc.main.id
  ingress {
    description     = "App from ALB"
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
  }
  ingress {
    description     = "SSH from Bastion"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = { Name = "startuptech-backend-sg" }
}
resource "aws_security_group" "mongodb" {
  name        = "startuptech-mongodb-sg"
  description = "MongoDB - 27017 from Backend, SSH from Bastion"
  vpc_id      = aws_vpc.main.id
  ingress {
    description     = "MongoDB from Backend"
    from_port       = 27017
    to_port         = 27017
    protocol        = "tcp"
    security_groups = [aws_security_group.backend.id]
  }
  ingress {
    description     = "SSH from Bastion"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = { Name = "startuptech-mongodb-sg" }
}
