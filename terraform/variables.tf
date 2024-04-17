variable "availability_zones" {
  description = "Availability Zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "security_group_ids" {
  description = "Security Groups IDs"
  type        = list(string)
  default     = ["sg-000935136986ff5b7"]
}

variable "vpc_id" {
  type    = string
  default = "vpc-08a2d9585586a3dfe"
}

variable "vpc_cidr_blocks" {
  type    = list(string)
  default = ["172.31.0.0/16"]
}