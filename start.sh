#!/bin/bash
echo "############################################################"
echo "##############                                ##############"
echo "############## ===== System Preparation ===== ##############"
echo "##############                                ##############"
echo "############################################################"
sudo yum -y update
sudo yum -y upgrade
sudo yum -y install git wget unzip
echo "############################################################"
echo "##############                                ##############"
echo "############## ======== Install  RKE ======== ##############"
echo "##############                                ##############"
echo "############################################################"
sudo wget -c --progress=bar -O /usr/bin/rke  https://github.com/rancher/rke/releases/download/v0.2.8/rke_linux-amd64
sudo chmod +x /usr/bin/rke
echo "############################################################"
echo "##############                                ##############"
echo "############## ===== Install  Terraform ===== ##############"
echo "##############                                ##############"
echo "############################################################"
sudo wget -c --progress=bar https://releases.hashicorp.com/terraform/0.12.9/terraform_0.12.9_linux_amd64.zip
sudo unzip terraform_0.12.9_linux_amd64.zip -d /usr/bin/
sudo chmod +x /usr/bin/terraform
sudo rm -rf terraform_0.12.9_linux_amd64.zip
echo "############################################################"
echo "##############                                ##############"
echo "############## ====== Start  Terraform ====== ##############"
echo "##############                                ##############"
echo "############################################################"
cp ../account.json account.json
terraform init
terraform apply -auto-approve
echo "############################################################"
echo "##############                                ##############"
echo "############## ======= CLUSTER  READY ======= ##############"
echo "##############                                ##############"
echo "############################################################"