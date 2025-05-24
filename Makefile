GOPATH := $(shell go env GOPATH)
VERSION := $(shell git describe --tags --always)
DIR := $(shell pwd)

SRV_PROTO_DIR = dtm event oidc user sys saas realtime gateway payment order product
PKG_PROTO_DIR = $(patsubst %/,%,$(shell cd pkg && ls -d */))
OTHER_PROTO_DIR = $(patsubst %/,%,$(shell cd proto && ls -d */))
THIRD_PARTY_PROTO_DIR = errors google lbs protoc-gen-openapiv2 validate

PROTOC_GEN_GO := $(shell which protoc-gen-go)
PROTOC_GEN_GO_GRPC := $(shell which protoc-gen-go-grpc)
PROTOC_GEN_VALIDATE := $(shell which protoc-gen-validate)
PROTOC_GEN_GO_HTTP := $(shell which protoc-gen-go-http)
PROTOC_INCLUDE := -I. -I./proto -I$(GOPATH)/pkg/mod/github.com/envoyproxy/protoc-gen-validate@v1.0.2

.PHONY: init
# Instala plugins protoc necesarios
init:
	go install github.com/go-kratos/kratos/cmd/kratos/v2@latest
	go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
	go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
	go install github.com/go-kratos/kratos/cmd/protoc-gen-go-http/v2@latest
	go install github.com/envoyproxy/protoc-gen-validate@v1.0.2

.PHONY: proto
# Genera todos los archivos .pb.go a partir de los .proto (manual, sin buf)
proto:
	@echo "Buscando .proto y generando .pb.go ..."
	@find . -type f -name "*.proto" \
	  ! -path "./cmd/*" \
	  ! -path "./proto/google/*" \
	  ! -path "./proto/protoc-gen-openapiv2/*" \
	  ! -path "./proto/validate/*" | \
	  while read proto; do \
	    echo "Procesando $$proto"; \
	    protoc $(PROTOC_INCLUDE) \
	      --go_out=paths=source_relative:. \
	      --go-grpc_out=paths=source_relative:. \
	      --validate_out=lang=go,paths=source_relative:. \
	      $$proto; \
	  done
	@echo "Generación de protos finalizada."

.PHONY: build
build:
	go build ./...

.PHONY: test
test:
	go test ./...

.PHONY: all
all: proto build test

.DEFAULT_GOAL := help

help:
	@echo ''
	@echo 'Usage:'
	@echo '  make [target]'
	@echo ''
	@echo 'Targets:'
	@echo '  init         Instala plugins protoc necesarios'
	@echo '  proto        Genera todos los .pb.go desde los .proto'
	@echo '  build        Compila el proyecto'
	@echo '  test         Ejecuta los tests'
	@echo '  all          proto + build + test'
	@echo '  help         Muestra este mensaje'