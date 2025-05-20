sum(node_namespace_pod_container:container_cpu_usage_seconds_total:sum_rate5m{namespace="$namespace", pod="$pod", cluster="$cluster", container!=""}) by (container)

sum(
    kube_pod_container_resource_requests{job="kube-state-metrics", cluster="$cluster", namespace="$namespace", pod="$pod", resource="cpu"}
)

sum(
    kube_pod_container_resource_limits{job="kube-state-metrics", cluster="$cluster", namespace="$namespace", pod="$pod", resource="cpu"}
)
