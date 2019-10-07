output "balancer_ip" {
  value = google_compute_global_address.default_master.address
}

output "instances_nodes" {
  value = google_compute_instance_from_template.default_node.*.network_interface.0.access_config.0.nat_ip
}

output "instances_masters" {
  value = google_compute_instance_from_template.default_master.*.network_interface.0.access_config.0.nat_ip
}
