output "cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = module.eks.cluster_endpoint
}

output "cluster_name" {
  description = "EKS cluster name"
  value       = module.eks.cluster_name
}

output "cluster_security_group_id" {
  description = "Security group ID attached to the EKS cluster"
  value       = module.eks.cluster_security_group_id
}

output "aws_region" {
  description = "AWS region"
  value       = var.aws_region
}

output "app_url" {
  description = "URL of the deployed application"
  value       = module.k8s_app.app_url
}
