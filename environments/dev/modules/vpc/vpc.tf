resource "google_compute_network" "vpc-test" {
  name                    = var.network_name
  project                 = var.project_id
  description             = "This is test VPC"
  auto_create_subnetworks  = false
}
