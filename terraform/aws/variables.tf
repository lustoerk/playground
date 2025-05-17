# GENERAL
variable "region" {
  description = "gcp region for specified instance"
  type = string
  default = "eu-central-1"
}

variable "zone" {
  description = "gcp region for specified instance"
  type = string
  default = "eu-central-1-a"
}

variable "admin_user_email" {
  description = "Admin User Email"
  type = string
}

variable "bucket" {
  description = "Bucket"
  type = string
}

# INSTANCES
variable "instance_type" {
  type = string
  default = "t2.small"
}

variable "instance_count" {
  type        = number
  default     = 3
}

variable "ami" {
  description = "The image from which to initialize the boot disk"
  type        = string
  default     = "ami-02b7d5b1e55a7b5f1"
}

# NETWORKING
variable "network" {
  description = "network for given instance"
  default = "default"
}

variable "domain" {
  description = "domain used for host records"
  type = string
  default = "stoerk.tech"
}

# variable "credential" {
#   description = "credential file path different for different users"
#   default = "keyfile.json"
# }

# variable "tags" {
#   type = "list"
#   description = "tags is used for defining the rule of a instance"
# }

# variable "service_account" {
#   default = "service.account@gmail.com"
# }