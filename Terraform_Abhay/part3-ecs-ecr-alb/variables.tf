variable "aws_region" {
  description = "AWS region for the deployment"
  type        = string
  default     = "ap-southeast-2"
}

variable "project_name" {
  description = "Prefix used for Terraform-managed resource names"
  type        = string
  default     = "abhay-tf-part3"
}

variable "backend_ecr_repository" {
  description = "Existing ECR repository containing the Flask image"
  type        = string
  default     = "abhay-flask-backend"
}

variable "frontend_ecr_repository" {
  description = "Existing ECR repository containing the Express image"
  type        = string
  default     = "abhay-express-frontend"
}

variable "service_discovery_namespace" {
  description = "Private DNS namespace used by ECS service discovery"
  type        = string
  default     = "abhay-tf.local"
}

variable "task_cpu" {
  description = "Fargate task CPU units (256 = 0.25 vCPU)"
  type        = number
  default     = 256
}

variable "task_memory" {
  description = "Fargate task memory in MiB"
  type        = number
  default     = 512
}

variable "desired_count" {
  description = "Number of running tasks for each ECS service"
  type        = number
  default     = 1
}
