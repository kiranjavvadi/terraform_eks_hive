output "app_url" {
  description = "URL of the deployed application"
  value       = kubernetes_service.app.status[0].load_balancer[0].ingress[0].hostname
}
