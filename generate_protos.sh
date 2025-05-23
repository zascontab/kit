#!/bin/bash
set -e

PROTOC_GEN_GO=$(which protoc-gen-go)
PROTOC_GEN_GO_GRPC=$(which protoc-gen-go-grpc)
PROTOC_GEN_GO_HTTP=$(which protoc-gen-go-http)
PROTOC_GEN_GO_GRPC_PROXY="$(pwd)/cmd/protoc-gen-go-grpc-proxy"
PROTOC_GEN_GO_ERRORS_I18N="$(pwd)/cmd/protoc-gen-go-errors-i18n"
PROTOC_GEN_VALIDATE=$(which protoc-gen-validate)

PROTOC_INCLUDE="-I. -I./proto -I$(go env GOPATH)/pkg/mod/github.com/envoyproxy/protoc-gen-validate@v1.0.2"

export PATH=$PATH:$(go env GOPATH)/bin

PROTO_FILES=$(find . -type f -name "*.proto" \
  ! -path "./cmd/*" \
  ! -path "./proto/google/*" \
  ! -path "./proto/protoc-gen-openapiv2/*" \
  ! -path "./proto/validate/*" \
  | sort)

echo "Archivos .proto encontrados para generar:"
echo "$PROTO_FILES"
echo "Generando código Go para todos los protos..."

for proto in $PROTO_FILES; do
  echo "Procesando $proto"
  protoc $PROTOC_INCLUDE \
    --go_out=paths=source_relative:. \
    --go-grpc_out=paths=source_relative:. \
    --go-http_out=paths=source_relative:. \
    --go-grpc-proxy_out=paths=source_relative:. \
    --go-errors-i18n_out=paths=source_relative:. \
    --validate_out=lang=go,paths=source_relative:. \
    "$proto"
done

echo "Generación de protos finalizada."