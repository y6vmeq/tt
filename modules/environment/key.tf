resource "tls_private_key" "default" {
  algorithm   = "RSA"
  depends_on = [google_compute_firewall.default]
}

resource "local_file" "default" {
    content     = tls_private_key.default.private_key_pem
    filename = "./keys/${var.meta_info.owner}"
}
