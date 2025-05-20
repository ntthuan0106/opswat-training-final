# Monitoring by Prometheus and Grafana

## Intallation

```bash
# Install 
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

kubectl create namespace monitoring
helm install monitoring prometheus-community/kube-prometheus-stack -n monitoring
helm uninstall monitoring

# Get Grafana 'admin' user password by running:
kubectl --namespace monitoring get secrets monitoring-grafana -o jsonpath="{.data.admin-password}" | base64 -d ; echo

# Upgrade chart
helm upgrade monitoring prometheus-community/kube-prometheus-stack \
  -n monitoring \
  -f values.yml
```

## Set up dashboard

1. Create folder
2. Create dashboard --> Add Visualiztion

## Set up alert

1. Create contact point
2. Go Alerting -> Add Alert rule
