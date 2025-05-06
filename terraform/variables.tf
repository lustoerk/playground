variable "project_id" {
  description = "project id in which we will create all instance"
  type = string
}

variable "region" {
  description = "gcp region for specified instance"
  default = "us-east1"
}

variable "zone" {
  description = "gcp region for specified instance"
  default = "us-east1-c"
}

variable "instance_name" {
  type = string
  default = "test"
}

variable "old_instance" {
  type = string
  default = "test"
}

variable "instance_type" {
  description = "specified image id for instance"
  default = "f1-micro"
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