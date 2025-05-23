#!/bin/bash
echo "===== FECHA Y HORA ====="
date
echo

echo "===== VERSIÓN DE GO ====="
go version
echo

echo "===== VERSIÓN DE PROTOC ====="
protoc --version || echo "protoc no encontrado"
echo

echo "===== VERSIÓN DE protoc-gen-go ====="
protoc-gen-go --version 2>/dev/null || which protoc-gen-go || echo "protoc-gen-go no encontrado"
echo

echo "===== VERSIÓN DE protoc-gen-go-grpc ====="
protoc-gen-go-grpc --version 2>/dev/null || which protoc-gen-go-grpc || echo "protoc-gen-go-grpc no encontrado"
echo

echo "===== VERSIÓN DE protoc-gen-validate (si aplica) ====="
protoc-gen-validate --version 2>/dev/null || which protoc-gen-validate || echo "protoc-gen-validate no encontrado"
echo

echo "===== go.mod ====="
cat go.mod
echo

echo "===== go.sum (primeras 30 líneas) ====="
head -30 go.sum
echo

echo "===== LISTA DE MÓDULOS GO INSTALADOS ====="
go list -m all || echo "No se pudo listar módulos"
echo

echo "===== UBICACIÓN DE PROTOC Y PLUGINS BINARIOS ====="
which go
which protoc
which protoc-gen-go
which protoc-gen-go-grpc
which protoc-gen-validate
echo

echo "===== COMANDOS DE GENERACIÓN DE PROTOS (si tienes script) ====="
cat ./generate_protos.sh 2>/dev/null || echo "No existe generate_protos.sh"
echo

echo "===== CHECKSUM DE TODOS LOS .proto ====="
find . -name '*.proto' | sort | xargs md5sum