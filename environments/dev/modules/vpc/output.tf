output "network" {
  value = google_compute_network.vpc-test
}

output "network_name" {
  value = google_compute_network.vpc-test.name
}
