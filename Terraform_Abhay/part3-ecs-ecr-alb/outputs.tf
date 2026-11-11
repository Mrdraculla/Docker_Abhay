output "application_url" {
  description = "Public URL of the application through the ALB"
  value       = "http://${aws_lb.app.dns_name}"
}

output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = aws_lb.app.dns_name
}

output "ecs_cluster_name" {
  description = "ECS cluster name"
  value       = aws_ecs_cluster.main.name
}

output "backend_service_name" {
  description = "ECS backend service name"
  value       = aws_ecs_service.backend.name
}

output "frontend_service_name" {
  description = "ECS frontend service name"
  value       = aws_ecs_service.frontend.name
}

output "backend_image" {
  description = "Existing ECR image used by the Flask task"
  value       = "${data.aws_ecr_repository.backend.repository_url}@${data.aws_ecr_image.backend.image_digest}"
}

output "frontend_image" {
  description = "Existing ECR image used by the Express task"
  value       = "${data.aws_ecr_repository.frontend.repository_url}@${data.aws_ecr_image.frontend.image_digest}"
}
