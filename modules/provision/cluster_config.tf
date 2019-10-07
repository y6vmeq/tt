resource "local_file" "default" {
    content     = templatefile("data/template/cluster.yaml.tpl", {
      path = "./keys/${var.meta_info.owner}"
      user = var.meta_info.owner
      balancer_ip = var.balancer_ip
      node_ips = var.instances_nodes
      master_ips = var.instances_masters
    })
    filename = "data/info/cluster.yaml"
}
