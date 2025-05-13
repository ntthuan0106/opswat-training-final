#!/bin/bash

set -euo pipefail

# Đường dẫn thư mục chứa file cần mã hóa
INPUT_DIR="./sensitive"
# Đường dẫn thư mục chứa file đầu ra đã mã hóa
OUTPUT_DIR="./encrypted"

# Yêu cầu người dùng nhập KMS_ID thủ công
read -rp "🔐 Nhập AWS KMS ID (arn:aws:kms:...): " KMS_ID

# Kiểm tra nếu người dùng không nhập gì
if [[ -z "$KMS_ID" ]]; then
  echo "❌ Bạn chưa nhập KMS ID. Thoát script."
  exit 1
fi

# Tạo thư mục đầu ra nếu chưa tồn tại
mkdir -p "$OUTPUT_DIR"

# Lặp qua tất cả file .yml và .yaml trong thư mục INPUT_DIR
for file in "$INPUT_DIR"/*.yml "$INPUT_DIR"/*.yaml; do
  [ -e "$file" ] || continue  # Bỏ qua nếu không có file phù hợp

  filename=$(basename "$file")                   # postgres.yml
  base="${filename%.*}"                          # postgres
  output="$OUTPUT_DIR/${base}.encrypted.yml"     # secrets/postgres.encrypted.yml

  echo "🔐 Encrypting $file -> $output ..."
  sops --encrypt --kms "$KMS_ID" "$file" > "$output"
done

echo "✅ Tất cả file đã được mã hóa thành công!"
