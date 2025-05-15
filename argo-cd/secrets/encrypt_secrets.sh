#!/bin/bash

set -euo pipefail

# Đường dẫn thư mục chứa file cần mã hóa
INPUT_DIR="./sensitive"
# Đường dẫn thư mục chứa file đầu ra đã mã hóa
OUTPUT_DIR="./encrypted"

# Tạo thư mục đầu ra nếu chưa tồn tại
mkdir -p "$OUTPUT_DIR"

# Lặp qua tất cả file .yml và .yaml trong thư mục INPUT_DIR
for file in "$INPUT_DIR"/*.yml "$INPUT_DIR"/*.yaml; do
  [ -e "$file" ] || continue  # Bỏ qua nếu không có file phù hợp

  filename=$(basename "$file")                   # postgres.yml
  base="${filename%.*}"                          # postgres
  output="$OUTPUT_DIR/${base}.encrypted.yml"     # secrets/postgres.encrypted.yml

  echo "🔐 Encrypting $file -> $output ..."
  sops --encrypt "$file" > "$output"
done

echo "✅ Tất cả file đã được mã hóa thành công!"
