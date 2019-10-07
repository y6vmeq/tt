resource "google_compute_network" "default" {
  name = "${var.name}-network"
  project = var.project
}

resource "google_compute_firewall" "default" {
  for_each = var.firewall_rules
  name = "${var.name}-firewall-${each.key}"
  project = var.project
  network = google_compute_network.default.self_link
  allow {
    protocol = "tcp"
    ports = each.value
  }
}
