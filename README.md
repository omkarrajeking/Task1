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
🚀 Deployment Steps
1. Clone the Repository
bash
Copy
Edit
git clone https://github.com/your-username/terraform-aws-ecs-next-app.git
cd terraform-aws-ecs-next-app
2. Initialize Terraform
bash
Copy
Edit
terraform init
3. Apply Terraform Configuration
bash
Copy
Edit
terraform apply
🐳 Build & Push Docker Image to ECR
Step 1: Authenticate Docker to ECR
bash
Copy
Edit
aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin <account-id>.dkr.ecr.ap-south-1.amazonaws.com
Step 2: Build, Tag & Push Docker Image
bash
Copy
Edit
docker build -t privaterepoomkar .
docker tag privaterepoomkar:latest <account-id>.dkr.ecr.ap-south-1.amazonaws.com/privaterepoomkar:latest
docker push <account-id>.dkr.ecr.ap-south-1.amazonaws.com/privaterepoomkar:latest
🔍 Verify Deployment
✅ 1. Check GitHub Actions (if used)
Go to your GitHub repo → Actions tab

Ensure workflows completed successfully

✅ 2. Check EC2 Instance
Go to AWS EC2 Console

Confirm a t2.micro instance is running

It should be in us-east-1a

Instance should have tag: Name: ecs-instance

✅ 3. Check ECS Cluster
Go to ECS Console

Verify nginx-cluster is active

Confirm nginx-service is running

Tasks should be in RUNNING state

✅ 4. Verify Next.js Application
Go to EC2 console → find public IP

Visit in browser: http://<public-ip>:3000

You should see your Next.js app

📈 Auto-Scaling Configuration
This deployment includes Auto Scaling for the ECS service based on CPU utilization:

Condition	Action	Period	Threshold
CPU > 80% for 2 periods	Scale up	60s	80%
CPU < 20% for 3 periods	Scale down	120s	20%
Min size: 1

Max size: 2

Auto Scaling Policy is tied to ECS Service

🧾 Terraform Output Example
hcl
Copy
Edit
output "ecs_security_group" {
  value = [aws_security_group.ecs_security_group]
}
You may add other useful outputs like:

ECS Cluster Name

Task Definition ARN

Public IP of EC2

ECR Repository URL

💰 Cost Awareness
This deployment uses AWS Free Tier eligible resources by default:

✅ t2.micro EC2 instance (750 hours/month)

✅ ECS cluster (free — you pay only for the EC2)

✅ Elastic Container Registry (ECR) (500 MB/month free)

✅ CloudWatch Basic Monitoring

💡 Important: Always monitor your AWS Billing Dashboard to avoid unexpected charges. Using multiple services outside free tier limits may incur costs.

🔧 Example Dockerfile
dockerfile
Copy
Edit
FROM node:18-alpine

WORKDIR /app
COPY . .
RUN npm install
RUN npm run build

EXPOSE 3000
CMD ["npm", "start"]
Make sure your Next.js app listens on 0.0.0.0:3000 not just localhost.

🧹 Destroy Infrastructure
bash
Copy
Edit
terraform destroy
👨‍💻 Maintainer
Omkar
💼 GitHub
🔗 LinkedIn

📄 License
Licensed under the MIT License.

yaml
Copy
Edit

---

Let me know if you want this version as a downloadable `.md` file or packaged with your repo stru
