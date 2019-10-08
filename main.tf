module "environment" {
  source      = "./modules/environment"
  name = var.name
  project = var.project
  region = var.region
  machine_type = var.machine_type
  centos_image = var.centos_image
  firewall_rules = var.firewall_rules
  meta_info = var.meta_info
}

module "nodes" {
  source      = "./modules/nodes"
  template_self_link = module.environment.template_self_link
  network_self_link = module.environment.network_self_link
  name = var.name
  count_node_vm = var.count_node_vm
  count_master_vm = var.count_master_vm
  project = var.project
  region = var.region
  zone = var.zone
  meta_info = var.meta_info

}
module "provision" {
  source      = "./modules/provision"
  balancer_ip = module.nodes.balancer_ip
  instances_nodes = module.nodes.instances_nodes
  instances_masters = module.nodes.instances_masters
  meta_info = var.meta_info
  count_node_vm = var.count_node_vm
  count_master_vm = var.count_master_vm
}
