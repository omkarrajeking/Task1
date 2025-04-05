# 🌐 AWS ECS Deployment with Terraform – Next.js Application

This repository provides a complete infrastructure-as-code setup using **Terraform** to deploy a containerized **Next.js** application on **Amazon ECS (EC2 launch type)**. It includes integration with **Amazon ECR**, **CloudWatch Logs**, **IAM roles**, and **security group configuration** for a production-ready deployment pipeline.

---

## 📌 Key Features

- ✅ Provision ECS Cluster (EC2-based) with Task Definitions
- 🐳 Build and push Dockerized Next.js app to Amazon ECR
- 📦 ECS Task Definition to run the container
- 🔐 Security Group with access to HTTP (80), HTTPS (443), SSH (22), and custom app port (3000)
- 📊 Integrated CloudWatch Logs for container monitoring
- 💼 Fully automated using Terraform (modular and readable)

---

## 🧰 Prerequisites

Ensure you have the following installed and configured:

- [Terraform v1.3+](https://developer.hashicorp.com/terraform/downloads)
- [Docker](https://www.docker.com/)
- [AWS CLI](https://aws.amazon.com/cli/)
- AWS credentials configured (`aws configure`)
- IAM user/role with access to ECS, EC2, ECR, IAM, and CloudWatch

---

## 🗂️ Repository Structure

```bash
.
├── main.tf                 # ECS cluster, EC2 instance & network setup
├── ecr.tf                  # ECR repository configuration
├── task-definition.tf      # ECS task and container definitions
├── security-group.tf       # Security group with inbound rules
├── variables.tf            # Input variables
├── outputs.tf              # Terraform output values
├── README.md               # Project documentation
