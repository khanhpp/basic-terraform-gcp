resource "google_compute_instance" "nginx" {
  name         = "nginx"
  machine_type = "e2-micro"
  zone         = "asia-east2-a"

  tags = ["service", "proxy","app", "nginx"]

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7"
      size  = "20"
      type  = "pd-ssd"   
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }

  metadata_startup_script = "yum update && yum install -y nginx"
}
