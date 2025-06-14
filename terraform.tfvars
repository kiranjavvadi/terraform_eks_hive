aws_region      = "us-west-2"
cluster_name    = "hiive-devops-cluster"
environment     = "dev"
instance_types  = ["t3.medium"]
min_size        = 2
max_size        = 4
desired_size    = 2
app_name        = "nginx"
app_namespace   = "hiive-app"
container_image = "nginx:1.24"
replicas        = 3
