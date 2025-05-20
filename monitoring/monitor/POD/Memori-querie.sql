sum(container_memory_working_set_bytes{job="kubelet", metrics_path="/metrics/cadvisor", cluster="$cluster", namespace="$namespace", pod="$pod", container!="", image!=""}) by (container)

sum(
    kube_pod_container_resource_requests{job="kube-state-metrics", cluster="$cluster", namespace="$namespace", pod="$pod", resource="memory"}
)

sum(
    kube_pod_container_resource_limits{job="kube-state-metrics", cluster="$cluster", namespace="$namespace", pod="$pod", resource="memory"}
)
