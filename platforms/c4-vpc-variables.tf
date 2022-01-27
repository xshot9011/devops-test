# VPC Input Variables
# VPC Name
variable "vpc_name" {
  type        = string
  description = "VPC Name"
  default     = "vpc"
}

# VPC CIDR Block
variable "vpc_cidr_block" {
  type        = string
  description = "VPC CIDR Block"
  default     = "10.0.0.0/16"
}

# VPC Availability Zones
variable "vpc_availability_zones" {
  type        = list(string)
  description = "VPC Availability Zones"
  default     = ["ap-southeast-1a", "ap-southeast-1b"]
}

# VPC Public Subnets
variable "vpc_public_subnets" {
  type        = list(string)
  description = "VPC Public Subnets"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

# VPC Private Subnets
variable "vpc_private_subnets" {
  type        = list(string)
  description = "VPC Private Subnets"
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}

# VPC Enable NAT Gateway (True or False) 
variable "vpc_enable_nat_gateway" {
  type        = bool
  description = "Enable NAT Gateways for Private Subnets Outbound Communication"
  default     = true
}

# VPC Single NAT Gateway (True or False)
variable "vpc_single_nat_gateway" {
  type        = bool
  description = "Enable only single NAT Gateway in one Availability Zone to save costs during our demos"
  default     = true
}