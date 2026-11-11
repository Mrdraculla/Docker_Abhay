
output "frontend_instance_id" {
  description = "Frontend EC2 instance ID"
  value       = aws_instance.frontend.id
}

output "frontend_public_ip" {
  description = "Frontend public IP"
  value       = aws_instance.frontend.public_ip
}

output "frontend_url" {
  description = "Public application URL"
  value       = "http://${aws_instance.frontend.public_ip}"
}

output "backend_instance_id" {
  description = "Backend EC2 instance ID"
  value       = aws_instance.backend.id
}

output "backend_private_ip" {
  description = "Private IP of Flask backend"
  value       = aws_instance.backend.private_ip
}

output "frontend_ssh_command" {
  description = "SSH command for frontend EC2"
  value       = "ssh -i D:/AWS/AWS-Abhay-Mumbai-Key.pem ubuntu@${aws_instance.frontend.public_ip}"
}
