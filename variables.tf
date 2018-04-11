variable "region" {}

variable "access_key" {}

variable "secret_key" {}

variable "ssh_user" {
      "type" = "string",
      "default" = "ubuntu",
      "description" = "user name to login to the instance"
}

variable "ssh_key_name" {
      "default" = "ubuntu_key"
}

variable "image_id" {
      "type" = "string",
      "default" = "ami-a22323d8",
      "description" = "Image to use for instance"
}

variable "instance_type" {
      "type" = "string",
      "default" = "t2.2xlarge",
      "description" = "Instance type"
}

variable "playbookpath" {
      "default" = "./ansible"
}

variable "playbookname" {
      "default" = "playbook.yml"
}

variable "ssh_key_path" {
      "default" = "./keys"
}
variable "tag" {
      "default" = "BOM"
}
variable "value" {
      "default" = "bomfile_example.txt"
}
variable "branch" {
      "default" = "release/4.0"
}

