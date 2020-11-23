resource "google_compute_address" "static" {
  name = "ipv4-address"
}

resource "google_compute_address" "ephemeral_public_ip" {
  name = "ephemeral-public-ip"
  address_type = "EXTERNAL"
}

resource "google_compute_instance_template" "webapp" {
  name = "webapp"
  description = "Template is used to create a nginx instance"
  tags = ["nginx","http-server"]
  labels = {
    environment = "dev"
    project     = var.project_id
    app         = "nginx"
  }
  
  instance_description  = "nginx web server"
  machine_type          =  var.machine_type
  can_ip_forward        = false

  scheduling {
     automatic_restart  = true
  }
  
  disk {
    source_image = var.image_name
    auto_delete  = true
    boot         = true
  }
  
  network_interface {
    subnetwork = var.subnetwork_name
    
    access_config {
     nat_ip  = google_compute_address.ephemeral_public_ip.address
   }

  }

 
  metadata_startup_script = "sudo yum update -y && sudo yum install -y nginx && sudo service nginx start"


}

resource "google_compute_instance_from_template" "nginx" {
  name = var.machine_name
  zone = data.google_compute_zones.available.names[0]
  

  source_instance_template = google_compute_instance_template.webapp.id

}

#resource "google_compute_instance" "nginx" {
#  count        = 1
#  project      = var.project_id
#  name         = var.machine_name
#  machine_type = var.machine_type
#  zone         = data.google_compute_zones.available.names[0]
#
# 
#
#  boot_disk {
#    initialize_params {
#      image = "centos-cloud/centos-7"
#      size  = "20"
#      type  = "pd-ssd"   
#    }
#  }
#
#  network_interface {
#    network = var.network_name
#    subnetwork = var.subnetwork_name
#  }
#
#  metadata_startup_script = "yum update && yum install -y nginx"
#}
