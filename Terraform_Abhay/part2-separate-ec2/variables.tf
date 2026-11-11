
variable "aws_region" {
  description = "AWS deployment region"
  type        = string
  default     = "ap-southeast-2"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "key_pair_name" {
  description = "Existing AWS EC2 key pair"
  type        = string
  default     = "AWS-Abhay-Mumbai-Key"
}

variable "my_ip_cidr" {
  description = "Public IP allowed to access SSH"
  type        = string
  default     = "223.236.204.13/32"
}
