# Checklist de Implementación: go-saas/kit

## Paso 1: Configuración del entorno de desarrollo local

- [ ] **1.1. Configurar hot reload para los microservicios Go**
  - [ ] Elegiste una herramienta (por ejemplo: [air](https://github.com/cosmtrek/air), [fresh](https://github.com/gravityblast/fresh), [CompileDaemon](https://github.com/githubnemo/CompileDaemon))
  - [ ] El hot reload funciona al guardar cambios en archivos Go
  - [ ] Los microservicios pueden ejecutarse directamente (no en contenedor) con hot reload

- [ ] **1.2. Identificar y eliminar cualquier dependencia de buf**
  - [ ] No hay archivos `buf.yaml`, `buf.lock` ni workflows que usen buf
  - [ ] README y scripts no mencionan buf
  - [ ] El flujo de generación de protos es 100% con `protoc` y plugins

- [ ] **1.3. Preparar Docker Compose para levantar solo recursos externos**
  - [ ] El archivo `docker-compose.yml` tiene servicios solo para Kafka, DB, Redis, etc.
  - [ ] Los microservicios Go NO están en el `docker-compose.yml` (o están comentados)
  - [ ] Puedes levantar recursos externos con `docker compose up` y conectar desde Go local

---

## Paso 2: Automatización de la generación de protos

- [ ] **2.1. Definir el proceso manual de generación de código Go desde proto**
  - [ ] Puedes correr `protoc ...` y generar los `.pb.go` a mano para cualquier proto
  - [ ] Tienes documentado el comando y las rutas

- [x] **2.2. Escribir un script para automatizar la generación de protos**
  - [x] El script (`generate_protos.sh`) existe y funciona
  - [x] Usa `protoc` y plugins con `paths=source_relative`
  - [x] No genera carpetas duplicadas
  - [x] Es fácil de ejecutar: `./generate_protos.sh`

- [ ] **2.3. Documentar el uso del script y cómo integrarlo**
  - [ ] Hay instrucciones claras en el README y/o comentarios en el script
  - [ ] El README explica cómo regenerar protos y cuándo hacerlo

---

## Siguientes pasos

- [ ] **Validar que todo el entorno funciona**
  - [ ] Puedes correr los microservicios Go localmente y se conectan a los recursos Docker
  - [ ] Los protos generados no dan errores de import ni compilación
  - [ ] Las herramientas de hot reload funcionan junto con el entorno

- [ ] **Optimizar el flujo según necesidades reales**
  - [ ] El flujo es lo más simple posible para nuevos desarrolladores
  - [ ] El script de protos puede ser extendido si aparecen nuevos plugins o necesidades
  - [ ] Documentación siempre actualizada

---

### Notas rápidas

- Marca cada casilla `[x]` al completar el paso.
- Revisa en cada pull request que el flujo siga siendo simple y claro.
- Si algún paso se rompe por cambios de estructura, actualiza este checklist y la documentación.
