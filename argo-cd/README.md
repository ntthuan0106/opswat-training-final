# Argocd

## Config ArgoCD

```bash
kubectl apply \
    -f ./config/1-argocd-aws-secret.yml \
    -f ./config/1-service-account.yml \
    -f ./config/3-argocd-cm.yml
```

## Get ArgoCD admin password

```bash
aws eks update-kubeconfig --region us-east-1 --name thuan-cluster --profile minh

argocd admin initial-password -n argocd

argocd login a93e05b3c80cc49b5862bb79e314bc0c-397444898.us-east-1.elb.amazonaws.com --user
name admin --password qkOteiV6pD-0QsVO
```

## Create Docker imagePullSecret

```bash
docker login

kubectl create secret generic private-registry-secret \
  --from-file=.dockerconfigjson=$HOME/.docker/config.json \
  --type=kubernetes.io/dockerconfigjson \
  --namespace=go-coffeeshop
```
