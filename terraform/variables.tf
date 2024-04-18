variable "availability_zones" {
  description = "Availability Zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "security_group_ids" {
  description = "Security Groups IDs"
  type        = list(string)
  default     = ["sg-028f6f66674c71b3a"]
}

variable "vpc_id" {
  type    = string
  default = "vpc-09ee8444241f53fb9"
}

variable "vpc_cidr_blocks" {
  type    = list(string)
  default = ["172.31.0.0/16"]
}