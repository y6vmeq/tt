
resource "google_compute_global_address" "default_master" {
  name = "${var.name}-ip-for-master-balancer"
  project = var.project
}

resource "google_compute_backend_service" "default_master" {
  name = "${var.name}-master-backend-service"
  project = var.project
  health_checks = [ google_compute_health_check.default.self_link ]
  protocol = "HTTP"
  backend {
    group = google_compute_instance_group.default_master.self_link
  }
}

resource "google_compute_health_check" "default" {
  name = "${var.name}-http-health-check"
  project = var.project
  check_interval_sec = 60
  timeout_sec = 10
  healthy_threshold = 3
  unhealthy_threshold = 3
  http_health_check {
    request_path = "/"
    port = "80"
  }
}

resource "google_compute_url_map" "default_master" {
  name = "${var.name}-master-balanser"
  project = var.project
  default_service = google_compute_backend_service.default_master.self_link
}

resource "google_compute_target_http_proxy" "default_master" {
  name = "${var.name}-master-target-proxy"
  project = var.project
  url_map = google_compute_url_map.default_master.self_link
}

resource "google_compute_global_forwarding_rule" "default" {
  name = "${var.name}-master-forwarding-rule"
  project = var.project
  target = google_compute_target_http_proxy.default_master.self_link
  ip_address = google_compute_global_address.default_master.address
  port_range = "80"
}
