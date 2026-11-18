# backend-deployment-assessment - much-to-do

Go backend (port 8080, GET /health, CRUD for tasks/users) + MongoDB,
deployed with Terraform on AWS, containersied with Docker.

## Structure
much-to-do/
  terraform/ main.tf variables.tf outputs.tf terraform.tfvars.example user_data/
  Dockerfile, docker-compose.yml, .dockerignore, evidence/, README.md

## Quick start - AWS
cd terraform
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform validate
terraform plan
terraform apply
curl http://<backend-public-ip>:8080/health

## Clean up
cd terraform
terraform destroy