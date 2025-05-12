# GENERAL
variable "project_id" {
  description = "project id in which we will create all instance"
  type = string
}

variable "region" {
  description = "gcp region for specified instance"
  type = string
  default = "europe-west10"
}

variable "zone" {
  description = "gcp region for specified instance"
  type = string
  default = "europe-west10-a"
}

# INSTANCES
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

# SSH
variable "ssh_user" {
  description = "SSH username"
  type        = string
  default     = "ubuntu"
}

variable "ssh_public_key_path" {
  description = "Path to the SSH public key"
  type        = string
  default     = "~/.ssh/id_rsa_k3s.pub"
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