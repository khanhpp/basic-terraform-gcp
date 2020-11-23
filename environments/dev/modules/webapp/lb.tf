resource "google_compute_global_forwarding_rule" "dev_webapp" {
  name       = "globol-http-rule"
  target     = google_compute_target_http_proxy.dev_webapp.id
  port_range = "80"
}

resource "google_compute_target_http_proxy" "dev_webapp" {
  name        = "target-proxy-dev-webapp"
  description = "a description"
  url_map     = google_compute_url_map.dev_webapp.id
}

resource "google_compute_url_map" "dev_webapp" {
  name = "url-map-dev-webapp"
  description = "dev_webapp url map"
  default_service = google_compute_backend_service.dev_webapp.id
  
  host_rule {
    hosts = ["*"]
    path_matcher = "dev-webapp"
  }
  
  path_matcher {
    name = "dev-webapp"
    default_service = google_compute_backend_service.dev_webapp.id
    
    path_rule {
      paths  = ["/*"]
      service = google_compute_backend_service.dev_webapp.id
    }
  }
}

resource "google_compute_backend_service" "dev_webapp" {
  name = "dev-webapp"
  port_name = "http"
  protocol  = "HTTP"
  
  backend {
    group = google_compute_instance_group.web_app.id
  }

  health_checks = [
    google_compute_http_health_check.http_check.id
  ]
}

resource "google_compute_http_health_check" "http_check" {
  name                = "dev-health"
  request_path        = "/"
  check_interval_sec  = 2
  timeout_sec         = 1
}


resource "google_compute_instance_group" "web_app"{
  name         = "webapp"
  zone         = data.google_compute_zones.available.names[0]
  instances    = [google_compute_instance_from_template.nginx.id]
  named_port  {
    name = "http"
    port = "80"
  }

  depends_on = [google_compute_instance_from_template.nginx]
}
