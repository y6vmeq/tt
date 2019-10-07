resource "google_compute_instance_template" "default" {
  name = "${var.name}-tmpl"
  project = var.project
  region = var.region
  machine_type = var.machine_type
  network_interface {
    network = google_compute_network.default.self_link
    access_config {}
  }
  disk {
    source_image = var.centos_image
  }
  scheduling {
    automatic_restart = true
  }
  metadata = {
    sshKeys = "${var.meta_info.owner}:${tls_private_key.default.public_key_openssh}"
  }
  labels = var.meta_info
  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
  # metadata_startup_script = templatefile("data/template/user_data.sh.tpl", {
  #   user_name = var.meta_info.owner
  # })
}
