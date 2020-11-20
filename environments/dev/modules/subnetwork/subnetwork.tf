resource "google_compute_subnetwork" "public_subnet" {
  name          = var.public_subnet_name
  ip_cidr_range = var.public_subnet_cidr
  region        = var.public_subnet_region
  network       = var.network_name
  project       = var.project_id
}
