variable "bucket_arn" {
  type = string
}

variable "bucket_name" {
  type = string
}

variable "bucket_regional_domain_name" {
    type = string
}

# Tagging arguments
variable "tags" {
  type = map(string)
}