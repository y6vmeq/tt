  resource "null_resource" "provision_nodes" {
  count = var.count_node_vm
  provisioner "remote-exec" {
    inline = [ templatefile("data/template/user_data.sh.tpl", {
    user_name = var.meta_info.owner
    })]
  }
  connection {
    type     = "ssh"
    user     = var.meta_info.owner
    host = var.instances_nodes[count.index]
    private_key = var.private_key
  }
}

  resource "null_resource" "provision_masters" {
  count = var.count_master_vm
  provisioner "remote-exec" {
    inline = [ templatefile("data/template/user_data.sh.tpl", {
    user_name = var.meta_info.owner
    })]
  }
  connection {
    type     = "ssh"
    user     = var.meta_info.owner
    host = var.instances_masters[count.index]
    private_key = var.private_key
  }
}

resource "null_resource" "install_cluster" {
  provisioner "local-exec" {
    command = "rke up --config ${local_file.default.filename}"
  }
  depends_on = [null_resource.provision_masters, null_resource.provision_nodes]
}
