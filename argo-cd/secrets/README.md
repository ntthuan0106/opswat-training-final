# Encrypt data with SOPS

## Install sops

```bash
# Download the binary
curl -LO https://github.com/getsops/sops/releases/download/v3.10.2/sops-v3.10.2.linux.amd64

# Move the binary in to your PATH
sudo mv sops-v3.10.2.linux.amd64 /usr/local/bin/sops

# Make the binary executable
sudo chmod +x /usr/local/bin/sops
```

## Encrypt secret file

1. Use command

```bash
# Export KMS arn
export KMS_ARN=<arn:aws:kms:<region>:<user-id>:key/<key-id>>
cat <<EOF | envsubst > .sops.yml
creation_rules:
  - path_regex: .*\\.yml$
    encrypted_regex: "^data\$"
    kms: '$KMS_ARN'
EOF

# Generate secret
chmod +x encrypt_secrets.sh
./encrypt_secrets.sh
```

## Decrypt encrypted file

```bash
mkdir decrypted
sops --decrypt ./encrypted/postgres.encrypted.yml > ./decrypted/postgres.decrypted.yml
```
