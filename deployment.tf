provider "aws" {
  region = "${var.region}"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}

data "aws_ami" "ubuntu1404" {
  most_recent = true
  owners = [
    "099720109477"]
  filter {
    name = "name"
    values = [
      "ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }
  filter {
    name = "virtualization-type"
    values = [
      "hvm"]
  }
}

resource "aws_instance" "mirror" {
  ami           = "${data.aws_ami.ubuntu1404.id}"
  instance_type = "${var.instance_type}"
  key_name = "${var.ssh_key_name}"
  disable_api_termination = "false"
  instance_initiated_shutdown_behavior = "stop"
  monitoring = "false"
  security_groups = ["${aws_security_group.deployment_sec_grp.name}", "default"]
  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = 140
  }
  associate_public_ip_address = "true"
  tags {
    Name = "PNDA-mirror-server-ubuntu"
  }
}
output "mirror_server_ip" {
  value = "${aws_instance.mirror.public_ip}"
}

resource "local_file" "cluster_ip" {
  depends_on = [ "null_resource.ansiblerun" ]
  content = "${aws_instance.mirror.public_ip}"
  filename = "${path.cwd}/output.txt"
}

locals {
  private_ip="${replace(aws_instance.mirror.private_ip, ".", "-")}"

}

output "private_ip" {
  value = "${local.private_ip}"
}

resource "local_file" "hosts" {
  depends_on = [ "aws_instance.mirror" ]
  content = "mirror ansible_host=${aws_instance.mirror.public_ip} private_ip=${local.private_ip} tag=${var.tag} branch=${var.branch} value=${var.value}"
  filename = "${path.cwd}/hosts"
}

resource "null_resource" "keypermisions" {
  depends_on = [ "local_file.hosts" ]
  provisioner "local-exec" {
    command = "chmod 400 ${var.ssh_key_path}/*"
  }
}

resource "null_resource" "ansiblerun" {
  depends_on = [ "local_file.hosts", "null_resource.keypermisions" ]

  provisioner "local-exec" {
    command = "export ANSIBLE_CONFIG=./ansible/ansible.cfg && export ANSIBLE_HOST_KEY_CHECKING=False && ansible-playbook --user=${var.ssh_user} -i hosts --extra-vars branch=${var.branch} --key-file=${var.ssh_key_path}/${var.ssh_key_name}.pem ${var.playbookpath}/${var.playbookname}"
  }
}

resource "aws_security_group" "deployment_sec_grp" {
  description = "Mirror server security group"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }
  ingress {
    from_port   = 8585
    to_port     = 8585
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks  = ["0.0.0.0/0"]
  }

  tags {
    Name = "Mirror server secgrp"
  }
}

