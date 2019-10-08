
resource "google_compute_instance" "default_server" {
  name = "${var.name}-server"
  project = var.project
  zone = "${var.region}-${var.zone}"
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
}
resource "null_resource" "provision_nodes" {
  provisioner "remote-exec" {
    inline = [
      "wget https://releases.hashicorp.com/vault/1.2.3/vault_1.2.3_linux_amd64.zip",
      "sudo unzip vault_1.2.3_linux_amd64.zip -d /usr/local/bin/",
      "sudo rm -rf vault_1.2.3_linux_amd64.zip",
      "sudo chmod +x /usr/local/bin/vault",
      "vault server -dev -dev-listen-address=0.0.0.0:8200 &",
    ]
  }
  connection {
    type     = "ssh"
    user     = var.meta_info.owner
    host = google_compute_instance.default_server.network_interface.0.access_config.0.nat_ip
    private_key = var.private_key
  }
}
