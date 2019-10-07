resource "google_compute_instance_group" "default_master" {
  name = "${var.name}-master-group"
  project = var.project
  zone = "${var.region}-${var.zone}"
  instances = google_compute_instance_from_template.default_master.*.self_link
}

resource "google_compute_instance_from_template" "default_master" {
  count = var.count_master_vm
  name = "${var.name}-master-${count.index}"
  zone = "${var.region}-${var.zone}"
  source_instance_template = var.template_self_link
}
