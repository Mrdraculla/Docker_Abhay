
output "instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.app.id
}

output "public_ip" {
  description = "Public IPv4 address"
  value       = aws_instance.app.public_ip
}

output "public_dns" {
  description = "Public DNS of the EC2 instance"
  value       = aws_instance.app.public_dns
}

output "application_url" {
  description = "Public application URL"
  value       = "http://${aws_instance.app.public_ip}"
}

output "ssh_command" {
  description = "SSH command to connect to EC2"
  value       = "ssh -i D:/AWS/AWS-Abhay-Mumbai-Key.pem ubuntu@${aws_instance.app.public_ip}"
}
