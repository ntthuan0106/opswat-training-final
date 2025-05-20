# Argo CD

## Get ArgoCD admin password

## Create Docker imagePullSecret

```bash
aws eks update-kubeconfig --region <region> --name <cluster-name --profile <aws-profile>

docker login

kubectl create secret generic private-registry-secret \
  --from-file=.dockerconfigjson=$HOME/.docker/config.json \
  --type=kubernetes.io/dockerconfigjson \
  --namespace=go-coffeeshop
```

## Use KSOPS to encrypt secrets

Follow the steps listed [here](./secrets/README.md).
