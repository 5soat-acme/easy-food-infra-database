variable "availability_zones" {
  description = "Availability Zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "security_group_ids" {
  description = "Security Groups IDs"
  type        = list(string)
  default     = ["sg-02185146b549f752f"]
}

variable "vpc_id" {
  type    = string
  default = "vpc-05b06d841c26f3904"
}

variable "vpc_cidr_blocks" {
  type    = list(string)
  default = ["172.31.0.0/16"]
}