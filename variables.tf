variable "aws_region" {
    default = "us-east-1"
    description = "aws region"
}

variable "vpc_cidr" {
    description = "cidr block for the VPC"
    default     = "10.0.0.0/16"
}

# variable "kubernetes_version" {
#     description = "kubernetes version"
#     default     = "2.35.1"
# }

variable "cluster_version" {
    description = "cluster version"
    default     = "1.31"
}

variable "instance_type" {
    description = "type of instance"
    default = "t2.micro"
}