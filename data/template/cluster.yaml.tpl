cluster-name: test-cluster
nodes:
%{ for index, master_ip in master_ips ~}
  - address: ${master_ip}
    hostname_override: master${index}
    user: ${user}
    role: ['etcd', 'controlplane']
%{ endfor ~}
%{ for index, node_ip in node_ips ~}
  - address: ${node_ip}
    hostname_override: node${index}
    user: ${user}
    role: ['worker']
    labels:
      app: ingress
%{ endfor ~}

authentication:
  strategy: "x509"
  sans:
    - "${balancer_ip}"


ssh_key_path: ${path}
ssh_agent_auth: false

kubernetes_version: v1.15.2-rancher1-1
addon_job_timeout: 30

ignore_docker_version: true
docker_root_dir: "/var/lib/docker"

enable_cluster_alerting: false
enable_cluster_monitoring: false
enable_network_policy: false

local_cluster_auth_endpoint:
  enabled: true

ingress:
  provider: nginx
  node_selector:
    app: ingress

monitoring:
  provider: "metrics-server"

network:
  options:
    flannel_backend_type: "vxlan"
  plugin: canal

services:
  etcd:
    backup_config:
      enabled: true
      interval_hours: 1
      retention: 6
    extra_args:
      heartbeat-interval: 500
      election-timeout: 5000
  kube-controller:
    extra_args:
      node-monitor-period: 5s
      node-monitor-grace-period: 20s
      pod-eviction-timeout: 10s
  kube-api:
    always_pull_images: false
    pod_security_policy: false
    service_node_port_range: "30000-32767"
    extra_args:
      enable-admission-plugins: "NamespaceLifecycle,LimitRanger,ServiceAccount,DefaultStorageClass,DefaultTolerationSeconds,MutatingAdmissionWebhook,ValidatingAdmissionWebhook,ResourceQuota,NodeRestriction,PodNodeSelector"
      default-not-ready-toleration-seconds: 10
      default-unreachable-toleration-seconds: 10
