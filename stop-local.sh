#!/bin/bash

echo "Deteniendo servicios..."
pkill -f "go run cmd/user/main.go"
pkill -f "go run cmd/saas/main.go"
pkill -f "go run cmd/sys/main.go"

echo "Servicios detenidos"
