output "network_self_link" {
  value = google_compute_network.default.self_link
}
output "template_self_link" {
  value = google_compute_instance_template.default.self_link
}
output "private_key" {
  value = tls_private_key.default.private_key_pem
}
