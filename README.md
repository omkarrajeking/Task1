
# 🌐 AWS ECS Deployment with Terraform – Next.js and python Application

This repository provides a complete **Infrastructure-as-Code (IaC)** setup using **Terraform** to deploy a containerized **Next.js** application on **Amazon ECS (EC2 launch type)**. It's fully modular, production-ready, and integrated with **Amazon ECR**, **CloudWatch Logs**, **IAM roles**, and **Security Groups**.

---

## 📌 Key Features

- ✅ **Provision ECS Cluster (EC2-based)** with Task Definitions
- 🐳 **Build and Push Dockerized Next.js and python App** to Amazon ECR
- 📦 ECS **Task Definition** to run the container of Next.js and python
- 🔐 Security Group: 
- 📊 **CloudWatch Logs Integration** for Container Monitoring
- 🧱 **Fully Modularized Infrastructure** using Terraform

---

## 🧰 Prerequisites

Ensure the following tools are installed and configured:

- [Terraform v1.3+](https://www.terraform.io/downloads)
- [Docker](https://www.docker.com/get-started/)
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)
- AWS credentials via `aws configure`
- IAM access to ECS, EC2, ECR, IAM, and CloudWatch
- Node.js v20
- Python
- Next.js

---

## 🗂️ Repository Structure

```
.
├── next-app/                         # Next.js application code
├── main.tf                           # Main Terraform configuration
├── variables.tf                      # Global variables
├── outputs.tf                        # Global outputs
├── README.md                         # Documentation
└── modules/
    ├── vpc/
    ├── ecr/
    └── ecs/
```

---

## 🚀 Deployment Steps

### 1. Clone the Repository

```bash
git clone https://github.com/your-username/terraform-aws-ecs-next-app.git
cd terraform-aws-ecs-next-app
```

### 2. Initialize Terraform

```bash
terraform init
```

### 3. Apply Terraform Configuration

```bash
terraform apply
```

---

## 🐳 Build & Push Docker Image to ECR

### Step 1: Authenticate Docker with ECR

```bash
aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin <account-id>.dkr.ecr.ap-south-1.amazonaws.com
```

### Step 2: Build, Tag & Push Image

```bash
docker build -t privaterepoomkar .
docker tag privaterepoomkar:latest <account-id>.dkr.ecr.ap-south-1.amazonaws.com/privaterepoomkar:latest
docker push <account-id>.dkr.ecr.ap-south-1.amazonaws.com/privaterepoomkar:latest
```

---

## 🔍 Verify Deployment


### ✅ 1. EC2 Instance
- Open AWS EC2 Console
- Confirm a `t2.micro` instance is running in `us-east-1a`
- Should have tag: `Name=ecs-instance`

### ✅ 2. ECS Cluster
- Go to ECS Console
- Confirm `nginx-cluster` is active with `nginx-service` running

### ✅ 3. Application Check
✅1-open load balncer and go to DNS 

✅2- Find EC2 Public I in AWS Console
- Visit: `http://<public-ip>:3000`

---

## 📈 Auto-Scaling Configuration

| Condition            | Action    | Period | Threshold |
|----------------------|-----------|--------|-----------|
| CPU > 80% (2 times)  | Scale Up  | 60s    | 80%       |
| CPU < 20% (3 times)  | Scale Down| 120s   | 20%       |

- Min Size: `1`
- Max Size: `2`

---

## 🐳 Dockerfile Example

```Dockerfile
FROM node:18-alpine

WORKDIR /app
COPY . .
RUN npm install
RUN npm run build

EXPOSE 3000
CMD ["npm", "start"]
```

> **Note**: Ensure your Next.js app listens on `0.0.0.0:3000` instead of `localhost`.

---

## 💰 Cost Awareness

This deployment is designed for **AWS Free Tier**:

- ✅ `t2.micro` EC2 (750 hours/month)
- ✅ ECS Cluster (free — only pay for EC2)
- ✅ ECR (500 MB/month free)
- ✅ CloudWatch Basic Monitoring

💡 *Always monitor your [AWS Billing Dashboard](https://console.aws.amazon.com/billing/home) to avoid surprises.*

---

## 🧹 Destroy Infrastructure

```bash
terraform destroy
```

---

## 👨‍💻 Maintainer

**Omkar**  
📂 [GitHub]
---

