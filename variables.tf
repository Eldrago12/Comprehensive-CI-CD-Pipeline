variable "region" {
    type = string
}

variable "vpc_cidr" {
    type = string
}
variable "all_cidr" {
    type = string
}
variable "public_subnet1_cidr" {
    type = string
}
variable "availability_zone" {
    type = string
}
variable "public_subnet2_cidr" {
    type = string
}
variable "availability_zone2" {
    type = string
}
variable "private_subnet_cidr" {
    type = string
}
variable "jenkins_port" {
    type = number
}
variable "ssh_port" {
    type = number
}
variable "sonarqube_port" {
    type = number
}
variable "grafana_port" {
    type = number
}
variable "http_port" {
    type = number
}
variable "key_name" {
    type = string
}
variable "key_value" {
    type = string
}
variable "linux2_ami" {
    type = string
}
variable "micro_instance" {
    type = string
}
variable "small_instance" {
  type = string
}
variable "https_port" {
  type = number
}
variable "ubuntu_ami" {
  type = string
}