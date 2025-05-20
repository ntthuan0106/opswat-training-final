#Max CPU
sum(kube_node_status_capacity{cluster="$cluster", job="kube-state-metrics", node=~"$node", resource="cpu"})

# Component CPU
sum(node_namespace_pod_container:container_cpu_usage_seconds_total:sum_rate5m{cluster="$cluster", node=~"$node"}) by (pod)