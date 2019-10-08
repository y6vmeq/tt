resource "google_compute_instance_from_template" "default_server" {
  name = "${var.name}-server"
  project = var.project
  zone = "${var.region}-${var.zone}"
  source_instance_template = var.template_self_link
}
resource "null_resource" "provision_server" {
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
    host = google_compute_instance_from_template.default_server.network_interface.0.access_config.0.nat_ip
    private_key = file("./keys/${var.meta_info.owner}")
  }
}
