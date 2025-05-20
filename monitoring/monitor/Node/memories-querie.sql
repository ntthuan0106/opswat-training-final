sum(node_namespace_pod_container:container_memory_working_set_bytes{cluster="$cluster", node=~"$node",container!=""}) by (pod)

sum(cluster:namespace:pod_memory:active:kube_pod_container_resource_requests{cluster="$cluster", node=~"$node"}) by (pod)

sum(node_namespace_pod_container:container_memory_working_set_bytes{cluster="$cluster", node=~"$node",container!=""}) by (pod) / sum(cluster:namespace:pod_memory:active:kube_pod_container_resource_requests{cluster="$cluster", node=~"$node"}) by (pod)