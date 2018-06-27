variable "region" {
  default = "us-east-1"
}

variable "bucket_name" {
  default = "dev.kukudkoo.cluster.k8s.local"
}

variable "cidr_block" {
  default = "10.11.0.0/16"
}

variable "Name" {
  default = "kukudkoo.k8s.local"
}

variable "domain_name" {
  default = "ec2.internal"
}

#################### Utility Subent Variables ########################
variable "utility_subnet_1a_cidr" {
  default = "10.11.4.0/24"
}

variable "utility_subnet_1b_cidr" {
  default = "10.11.5.0/24"
}

variable "utility_subnet_1c_cidr" {
  default = "10.11.6.0/24"
}

#################### MASTER Subent Variables ########################

variable "master_subnet_1a_cidr" {
  default = "10.11.1.0/24"
}

variable "master_subnet_1b_cidr" {
  default = "10.11.2.0/24"
}

variable "master_subnet_1c_cidr" {
  default = "10.11.3.0/24"
}

#################### NODE Subent Variables ########################
variable "node_subnet_1a_cidr" {
  default = "10.11.7.0/24"
}

variable "node_subnet_1b_cidr" {
  default = "10.11.8.0/24"
}

variable "node_subnet_1c_cidr" {
  default = "10.11.9.0/24"
}
