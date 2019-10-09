resource "google_compute_instance_from_template" "default_server" {
  name = "${var.name}-server"
  project = var.project
  zone = "${var.region}-${var.zone}"
  source_instance_template = var.template_self_link
}
resource "null_resource" "server_provision" {
  provisioner "remote-exec" {
    inline = [<<EOF
      sudo yum -y install wget unzip
      wget https://releases.hashicorp.com/vault/1.2.3/vault_1.2.3_linux_amd64.zip
      sudo unzip vault_1.2.3_linux_amd64.zip -d /usr/bin/
      sudo rm -rf vault_1.2.3_linux_amd64.zip
      sudo chmod +x /usr/bin/vault
      EOF
    ]
  }
  connection {
    type     = "ssh"
    user     = var.meta_info.owner
    host = google_compute_instance_from_template.default_server.network_interface.0.access_config.0.nat_ip
    private_key = file("./keys/${var.meta_info.owner}")
  }
}
