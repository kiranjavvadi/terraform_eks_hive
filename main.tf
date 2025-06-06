module "vpc" {
  source = "./modules/vpc"

  cluster_name = var.cluster_name
  aws_region   = var.aws_region
  environment  = var.environment
}

module "eks" {
  source = "./modules/eks"

  cluster_name    = var.cluster_name
  vpc_id          = module.vpc.vpc_id
  subnet_ids      = module.vpc.private_subnet_ids
  aws_region      = var.aws_region
  environment     = var.environment
  instance_types  = var.instance_types
  min_size        = var.min_size
  max_size        = var.max_size
  desired_size    = var.desired_size
}

module "k8s_app" {
  source = "./modules/k8s-app"

  cluster_name        = module.eks.cluster_name
  cluster_endpoint    = module.eks.cluster_endpoint
  cluster_ca_cert     = module.eks.cluster_ca_cert
  app_name           = var.app_name
  app_namespace      = var.app_namespace
  container_image    = var.container_image
  replicas           = var.replicas
  
  depends_on = [module.eks]
}
