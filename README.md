# AWS EKS Terraform Module - DevOps Take-Home Assignment

This repository contains a Terraform module that deploys a containerized service to AWS EKS (Elastic Kubernetes Service) with all necessary infrastructure components including VPC, networking, and security configurations.

## Architecture Overview

The solution deploys:
- A VPC with public and private subnets across multiple availability zones
- An EKS cluster with managed node groups
- Required IAM roles and policies
- Security groups for cluster and node communication
- A sample NGINX deployment exposed via LoadBalancer service
- Kubernetes namespace and service configurations

## Prerequisites

- AWS CLI configured with appropriate credentials
- Terraform >= 1.0
- kubectl
- AWS IAM permissions to create EKS clusters, VPCs, and related resources

## Project Structure

```
.
├── README.md
├── main.tf
├── variables.tf
├── outputs.tf
├── versions.tf
├── modules/
│   ├── vpc/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── eks/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── k8s-app/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
└── examples/
    └── complete/
        ├── main.tf
        └── terraform.tfvars
```

## Step-by-Step Deployment Instructions

### 1. Clone the Repository

```bash
git clone <repository-url>
cd eks-terraform-module
```

### 2. Configure Variables

Create a `terraform.tfvars` file in the root directory:

```hcl
aws_region     = "us-west-2"
cluster_name   = "hiive-devops-cluster"
environment    = "dev"
```

### 3. Initialize Terraform

```bash
terraform init
```

### 4. Review the Deployment Plan

```bash
terraform plan
```

### 5. Deploy the Infrastructure

```bash
terraform apply -auto-approve
```

This process will take approximately 15-20 minutes to complete.

### 6. Configure kubectl

After the cluster is created, configure kubectl to interact with your cluster:

```bash
aws eks --region $(terraform output -raw aws_region) update-kubeconfig \
    --name $(terraform output -raw cluster_name)
```

### 7. Verify the Deployment

Check that the nodes are ready:

```bash
kubectl get nodes
```

Check the deployed application:

```bash
kubectl get pods -n hiive-app
kubectl get svc -n hiive-app
```

### 8. Access the Application

Get the LoadBalancer URL:

```bash
kubectl get svc -n hiive-app nginx-service -o jsonpath='{.status.loadBalancer.ingress[0].hostname}'
```

Wait a few minutes for the LoadBalancer to be provisioned, then access the application via the provided URL.

## Key Design Decisions

### 1. **Modular Architecture**
The Terraform code is organized into reusable modules (VPC, EKS, K8s-app) to promote code reusability and maintainability. Each module encapsulates specific functionality and can be independently versioned and tested.

### 2. **Network Security**
- **VPC Design**: Implements a multi-AZ VPC with both public and private subnets. The EKS worker nodes are placed in private subnets for enhanced security, while LoadBalancers are deployed in public subnets.
- **Security Groups**: Implements least-privilege security group rules, allowing only necessary communication between EKS control plane and worker nodes.
- **IAM Roles**: Uses separate IAM roles for the EKS cluster and node groups with minimal required permissions following AWS best practices.

### 3. **Scalability and High Availability**
- **Multi-AZ Deployment**: Resources are distributed across multiple availability zones for high availability.
- **Auto Scaling**: The EKS node group is configured with auto-scaling capabilities (min: 2, max: 4 nodes) to handle varying workloads.
- **Managed Node Groups**: Uses EKS managed node groups for simplified node management and automatic AMI updates.

### 4. **Production Readiness**
- **Tagging Strategy**: Implements consistent tagging for resource management and cost allocation.
- **Output Values**: Provides essential outputs for integration with CI/CD pipelines and other tools.
- **Version Constraints**: Pins provider and module versions to ensure reproducible deployments.

## Cleanup

To destroy all created resources:

```bash
terraform destroy -auto-approve
```

## Outputs

The module provides the following outputs:

- `cluster_endpoint` - EKS cluster endpoint
- `cluster_name` - Name of the EKS cluster
- `cluster_security_group_id` - Security group ID attached to the EKS cluster
- `app_url` - URL of the deployed application

## Security Considerations

- All sensitive data is managed through AWS IAM roles and policies
- Network traffic is restricted using security groups
- Nodes are deployed in private subnets
- Cluster endpoint access is configured for public access (can be restricted based on requirements)

