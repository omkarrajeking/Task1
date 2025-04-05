Of course, Omkar! Here's your **single, comprehensive `README.md` file** — all content merged into one clear and professional document. You can copy this directly into your repository.

---

### ✅ `README.md`

```markdown
# 🚀 Terraform AWS ECS Setup with Next.js App

This repository contains a complete setup to deploy a **Next.js application** on **Amazon ECS (EC2 launch type)** using **Terraform**. It includes ECR for container images, CloudWatch for logs, security groups for networking, and task definitions to run your app.

---

## 📦 Features

- 🚢 Deploys a Dockerized **Next.js** app to ECS
- 🐳 Manages ECR repository for storing Docker images
- 🔐 Configures Security Group with ports:
  - 22 (SSH)
  - 80 (HTTP)
  - 443 (HTTPS)
  - 3000 (App port)
- 📈 Sets up CloudWatch Logs for ECS container
- ⚙️ Task definition and execution IAM roles
- 🧱 Modular, readable Terraform code structure

---

## 🧰 Prerequisites

- [Terraform v1.3+](https://developer.hashicorp.com/terraform/downloads)
- [Docker](https://docs.docker.com/get-docker/)
- AWS CLI configured (`aws configure`)
- IAM user with permissions: ECS, ECR, IAM, EC2, CloudWatch

---

## 🗂️ Project Structure

```
.
├── main.tf                 # ECS service & EC2 setup
├── variables.tf            # Input variables
├── outputs.tf              # Output values
├── security-group.tf       # Security group rules
├── ecr.tf                  # Creates ECR repo
├── task-definition.tf      # ECS Task for Docker container
├── README.md               # Full guide (this file)
```

---

## 🚀 Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/your-username/terraform-aws-ecs-next-app.git
cd terraform-aws-ecs-next-app
```

### 2. Initialize Terraform

```bash
terraform init
```

### 3. Validate Configuration

```bash
terraform validate
```

### 4. Apply Configuration

```bash
terraform apply
```

---

## 🐳 Build and Push Docker Image to ECR

### 1. Authenticate Docker to ECR

```bash
aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin <your-account-id>.dkr.ecr.ap-south-1.amazonaws.com
```

### 2. Build Docker Image

```bash
docker build -t privaterepoomkar .
```

### 3. Tag Image

```bash
docker tag privaterepoomkar:latest <your-account-id>.dkr.ecr.ap-south-1.amazonaws.com/privaterepoomkar:latest
```

### 4. Push to ECR

```bash
docker push <your-account-id>.dkr.ecr.ap-south-1.amazonaws.com/privaterepoomkar:latest
```

---

## 🧪 Example Dockerfile for Next.js App

```Dockerfile
# Dockerfile
FROM node:18-alpine

WORKDIR /app
COPY . .
RUN npm install
RUN npm run build

EXPOSE 3000
CMD ["npm", "start"]
```

> ✅ Ensure your Next.js app listens on `0.0.0.0:3000`, not `localhost`, to allow ECS networking.

---

## 🔐 Security Group Configuration

| Type     | Protocol | Port | Source      |
|----------|----------|------|-------------|
| SSH      | TCP      | 22   | 0.0.0.0/0   |
| HTTP     | TCP      | 80   | 0.0.0.0/0   |
| HTTPS    | TCP      | 443  | 0.0.0.0/0   |
| Custom   | TCP      | 3000 | 0.0.0.0/0   |

Defined in `security-group.tf`.

---

## 📤 Terraform Outputs

```hcl
output "ecs_security_group" {
  value = [aws_security_group.ecs_security_group]
}
```

Other outputs may include ECS Task ARN, public IPs, or ECR repo URLs if added.

---

## 🧹 Destroy Resources

```bash
terraform destroy
```

---

## 🧠 Troubleshooting

- **Next.js not accessible?** Make sure:
  - Port 3000 is open in the security group
  - Container listens on `0.0.0.0:3000`
  - Task is pulling the right image from ECR

- **DNS resolution errors (e.g., `ENOTFOUND`)?**
  - Ensure container is running in the correct **network mode**
  - If using bridge mode, access app using public EC2 IP and mapped host port

---

## 👨‍💻 Author

**Omkar**  
🔗 [LinkedIn](https://linkedin.com/in/your-link)  
💻 [GitHub](https://github.com/your-username)

---

## 📝 License

Licensed under the [MIT License](LICENSE).

Feel free to use, modify, and share!
```

---

Let me know if you'd like a GitHub Actions pipeline, CI/CD support, or a version for Fargate-based ECS setup too!
