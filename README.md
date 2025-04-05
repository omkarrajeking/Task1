# 🌐 AWS ECS Deployment with Terraform – Next.js Application

This repository provides a complete infrastructure-as-code setup using **Terraform** to deploy a containerized **Next.js** application on **Amazon ECS (EC2 launch type)**. It includes integration with **Amazon ECR**, **CloudWatch Logs**, **IAM roles**, and security group configuration for a production-ready deployment pipeline.

---

## 📌 Key Features

- ✅ Provision ECS Cluster (EC2-based) with Task Definitions
- 🐳 Build and push Dockerized Next.js app to Amazon ECR
- 📦 ECS Task Definition to run the container
- 🔐 Security Group with access to HTTP (80), HTTPS (443), SSH (22), and custom app port (3000)
- 📊 Integrated CloudWatch Logs for container monitoring
- 💼 Fully modularized using Terraform

---

## 🧰 Prerequisites

Ensure you have the following installed and configured:

- [Terraform v1.3+](https://developer.hashicorp.com/terraform/downloads)
- [Docker](https://www.docker.com/)
- [AWS CLI](https://aws.amazon.com/cli/)
- AWS credentials configured (`aws configure`)
- IAM user/role with access to ECS, EC2, ECR, IAM, and CloudWatch
- Nextjs
- Python
- node v20

---

## 🗂️ Repository Structure

```bash
.
├── next-app                         #nextjs code
├── main.tf                          # Main entry to call all modules
├── variables.tf                     # Global variables
├── outputs.tf                       # Global outputs
├── README.md                        # Documentation

├── modules/
│   ├── vpc/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│
│
│   ├── ecr/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│
│   ├── ecs/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│
│   
