# GitHub Action

## Prequesite

### Create secret environment

1. Trivy scan environment

```text
Environment secrets:
- AWS_ACCESS_KEY_ID_MINH
- AWS_SECRET_ACCESS_KEY_MINH
- DOCKER_PASSWORD

Environment variables:
- AWS_REGION
- DOCKER_USERNAME
- DOCKER_HUB_PRIVATE_REPOSITORY_NAME
```

2. Dev environment

```text
Environment secrets:
- AWS_ACCESS_KEY_ID
- AWS_SECRET_ACCESS_KEY
- DOCKER_PASSWORD

Environment variables:
- AWS_REGION
- DOCKER_USERNAME
```

3. Prod environment

```text
Environment secrets:
- AWS_ACCESS_KEY_ID
- AWS_SECRET_ACCESS_KEY
- DB_PASSWORD

Environment variables:
- AWS_REGION
- DB_USERNAME
- ARGO_CD_CLUSTER_NAME
```
