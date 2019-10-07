resource "google_compute_instance_group" "default_node" {
  name = "${var.name}-node-group"
  project = var.project
  zone = "${var.region}-${var.zone}"
  instances = google_compute_instance_from_template.default_node.*.self_link
}

resource "google_compute_instance_from_template" "default_node" {
  count = var.count_node_vm
  name = "${var.name}-node-${count.index}"
  zone = "${var.region}-${var.zone}"
  source_instance_template = var.template_self_link
}
