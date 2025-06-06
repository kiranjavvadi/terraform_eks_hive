variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "cluster_endpoint" {
  description = "EKS cluster endpoint"
  type        = string
}

variable "cluster_ca_cert" {
  description = "EKS cluster CA certificate"
  type        = string
}

variable "app_name" {
  description = "Name of the application"
  type        = string
}

variable "app_namespace" {
  description = "Kubernetes namespace for the application"
  type        = string
}

variable "container_image" {
  description = "Container image to deploy"
  type        = string
}

variable "replicas" {
  description = "Number of replicas"
  type        = number
}
