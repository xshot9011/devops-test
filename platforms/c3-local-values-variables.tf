# AWS Region
variable "aws_region" {
  type        = string
  description = "Region in which AWS Resources to be created"
  default     = "ap-southeast-1"
}
# Environment Variable
variable "environment" {
  type        = string
  description = "Environment Variable used as a prefix"
  default     = "dev"
}
# Business Division
variable "business_divsion" {
  type        = string
  description = "Business Division in the large organization this Infrastructure belongs"
  default     = "SAP"
}