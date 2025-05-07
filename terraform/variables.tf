variable "project_id" {
  description = "project id in which we will create all instance"
  type = string
}

variable "region" {
  description = "gcp region for specified instance"
  type = string
  default = "us-east1"
}

variable "zone" {
  description = "gcp region for specified instance"
  type = string
  default = "us-east1-c"
}

variable "instance_type" {
  type = string
  default = "e2-small"
}

variable "instance_count" {
  type        = number
  default     = 3
}

variable "image" {
  description = "The image from which to initialize the boot disk"
  type        = string
  default     = "debian-cloud/debian-11"
}

variable "network" {
  description = "network for given instance"
  default = "default"
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