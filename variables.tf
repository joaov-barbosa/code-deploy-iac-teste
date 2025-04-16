variable "region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "vpc_id" {
  description = "VPC ID onde os recursos serão criados"
  type        = string
  default     = "vpc-0ff1cefd42486ad11"
}

variable "subnet_ids" {
  description = "Subnets onde o ASG e ALB serão criados"
  type        = list(string)
  default     = ["subnet-0098bc6d40f7cd425", "subnet-0c686c50eafd6ef44"]
}

variable "ami_id" {
  description = "AMI para as instâncias do Auto Scaling"
  type        = string
  default     = "ami-051f7e7f6c2f40dc1"
}
