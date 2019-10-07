name = "vault"
count_node_vm = 2
count_master_vm = 2
project = "plucky-weaver-247211"
region = "us-central1"
zone = "a"
machine_type = "n1-standard-2"
centos_image = "centos-7-v20190916"
firewall_rules = {
    ssh = ["22"],
    http-https = ["80", "443"],
    k8s        = ["179", "2379-2380", "6443", "8285", "8472", "10250", "30000-32767"],
    rancher    = ["8080"],
    vault      = ["8200"]
}
meta_info = {
    owner = "ihar_ratner",
    environment = "tech_talk"
}
