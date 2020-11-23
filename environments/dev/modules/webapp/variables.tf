variable "project_id" {
  description = "Project ID"
}

variable "image_name" {
  default = "centos-cloud/centos-7"
  description = "image name to use"

}

variable "region" {
  description = "Region"
}

variable "network_name" {
  description = "VPC name"
}

variable "subnetwork_name" {
  description = "Subnetwork"
}

variable "machine_name" {
  default = "nginx"
}

variable "machine_type" {
  default = "e2-micro"
}
