resource "google_compute_firewall" "nginx" {
  name    = "nginx"
  network = var.network_name

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "8080"]
  }
  
  direction = "INGRESS"
}
