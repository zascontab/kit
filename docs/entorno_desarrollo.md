# 🛠️ Guía para Levantar el Entorno de Desarrollo (Go + Protobuf + gRPC)

> **IMPORTANTE:**  
> Antes de actualizar versiones de Go, Protobuf, plugins o dependencias, ejecuta el script `tools/version_snapshot.sh` y guarda el log. Así puedes comparar o restaurar tu entorno si surge algún error masivo con los protos o build.

---

## 1. Prerrequisitos

- **Go**: La versión indicada en `go.mod` (`go 1.20` o superior si el proyecto lo permite).
- **protoc** (Protocol Buffers Compiler): Instala desde [releases](https://github.com/protocolbuffers/protobuf/releases).
- **Plugins**:
  - `protoc-gen-go`
  - `protoc-gen-go-grpc`
  - (opcional) `protoc-gen-validate`, `protoc-gen-go-http`, etc. según el script.
- **Dependencias Go** descargadas (`go mod tidy && go mod download`).

---

## 2. Instalación de herramientas

### A. Verifica Go

```bash
go version
# Si no tienes la versión correcta, instálala desde https://golang.org/dl/
```

### B. Instala/Actualiza protoc

```bash
protoc --version
# Si falta o es incorrecta, descarga e instala desde https://github.com/protocolbuffers/protobuf/releases
```

### C. Instala plugins de generación

```bash
# Asegúrate de tener $GOPATH/bin o $HOME/go/bin en tu $PATH
go install google.golang.org/protobuf/cmd/protoc-gen-go@v1.31.0
go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.3.0
go install github.com/envoyproxy/protoc-gen-validate@v1.0.2 # si es necesario

# (opcional, según tu script)
go install github.com/go-kratos/kratos/cmd/protoc-gen-go-http@latest
```

---

## 3. Instalación de dependencias Go

Desde la raíz del proyecto:

```bash
go mod tidy
go mod download
```

---

## 4. Generación de código a partir de protos

### A. Limpieza previa (opcional, recomendado)

```bash
find . -name '*.pb.go' -delete
find . -name '*.pb.gw.go' -delete
find . -name '*.pb.validate.go' -delete
```

### B. Generación

```bash
./generate_protos.sh
# Verifica que no haya errores ni warnings graves en la salida.
```

---

## 5. Compilación y pruebas

```bash
go build ./...
go test ./...
```

---

## 6. Otros servicios (Base de datos, Redis, etc.)

Si tu proyecto usa Docker o docker-compose para dependencias locales:

```bash
docker-compose up -d
# o sigue las instrucciones internas para servicios auxiliares
```

---

## 7. Snapshot de versiones y checksums (¡OBLIGATORIO ANTES DE CAMBIOS!)

Ejecuta esto y guarda el archivo log:

```bash
tools/version_snapshot.sh | tee version_snapshot_$(date +%Y%m%d_%H%M%S).log
```

---

## 8. NOTAS Y RECOMENDACIONES

- **Si cambias alguna versión (Go, protoc, plugins, módulos):**  
  - Borra todos los archivos generados
  - Regenera con el script
  - Haz un snapshot antes y después
- **Si aparecen errores en todos los archivos generados** tras un cambio de versión, revisa la alineación de versiones:
  - protoc, protoc-gen-go, protoc-gen-go-grpc, y las dependencias Go deben ser compatibles entre sí.
- **Nunca mezcles archivos generados con distintas versiones** de plugins o librerías.
- **Comparte el snapshot en el equipo** si actualizas algo crítico.

---

## 9. Recursos útiles

- [Go downloads](https://golang.org/dl/)
- [protoc releases](https://github.com/protocolbuffers/protobuf/releases)
- [protoc-gen-go](https://github.com/protocolbuffers/protobuf-go)
- [protoc-gen-go-grpc](https://github.com/grpc/grpc-go)
- [protoc-gen-validate](https://github.com/envoyproxy/protoc-gen-validate)

---