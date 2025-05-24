#!/bin/bash
set -e

# Todas las carpetas principales donde hay .proto que pueden ser importados
INCLUDES=(
  -I. 
  -I./proto
  -I./pkg
  -I./pkg/blob
  -I./pkg/email
  -I./pkg/redis
  -I./pkg/data
  -I./pkg/registry
  -I./pkg/query
  -I./pkg/conf
  -I./pkg/idp
  -I./pkg/price
  -I./pkg/stripe
  -I./pkg/authz/authz
  -I./saas/api/plan/v1
  -I./saas/api/tenant/v1
  -I./product/api/category/v1
  -I./product/api/price/v1
  -I./product/api/product/v1
  -I./user/api/account/v1
  -I./user/api/auth/v1
  -I./user/api/permission/v1
  -I./user/api/role/v1
  -I./user/api/user/v1
  # Puedes agregar más si encuentras errores de import
)

PROTOC_INCLUDE="${INCLUDES[*]}"

# Encuentra todos los archivos .proto relevantes (ajusta el find si quieres excluir algunos)
PROTO_FILES=$(find . -type f -name "*.proto" \
  ! -path "./cmd/*" \
  ! -path "./proto/google/*" \
  ! -path "./proto/protoc-gen-openapiv2/*" \
  ! -path "./proto/validate/*" \
  | sort)

echo "Generando código Go para todos los protos..."
for proto in $PROTO_FILES; do
  echo "Procesando $proto"
  protoc $PROTOC_INCLUDE \
    --go_out=paths=source_relative:. \
    --go-grpc_out=paths=source_relative:. \
    --validate_out=lang=go,paths=source_relative:. \
    "$proto"
done
echo "Generación de protos finalizada."