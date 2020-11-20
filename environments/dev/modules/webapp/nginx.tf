data "google_compute_zones" "available" {
  #project = var.project_id
  #region  = var.region
}

resource "google_compute_instance" "nginx" {
  count        = 1
  project      = var.project_id
  name         = var.machine_name
  machine_type = var.machine_type
  zone         = data.google_compute_zones.available.names[1]

  tags = ["service", "proxy","app", "nginx"]

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7"
      size  = "20"
      type  = "pd-ssd"   
    }
  }

  network_interface {
    network = var.network_name
    subnetwork = var.subnetwork_name
  }

  metadata_startup_script = "yum update && yum install -y nginx"
}
