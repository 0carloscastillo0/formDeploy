#!/bin/bash
# =====================================================
# 🏗️  Construir y subir imagen Docker al Docker Hub
# =====================================================

echo "🐳 Construyendo y publicando imagen Docker para DEPLOY..."

# Detectar la ruta raíz del proyecto
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ENV_FILE="$ROOT_DIR/.env.deploy"
IMAGE_NAME="xcarloscastillox/productos_app:latest"

# Verificar Docker
if ! command -v docker &> /dev/null; then
    echo "❌ Docker no está instalado."
    exit 1
fi

# Verificar archivo .env.deploy
if [ ! -f "$ENV_FILE" ]; then
    echo "❌ No se encontró el archivo .env.deploy"
    exit 1
fi

# Cargar variables (opcional)
export $(grep -v '^#' "$ENV_FILE" | xargs)

# Detener contenedores previos
echo "🧹 Deteniendo contenedores previos..."
docker compose -f "$ROOT_DIR/docker-compose.yml" --env-file "$ENV_FILE" down -v || true

# Construir imagen localmente
echo "🏗️  Construyendo imagen sin caché..."
docker build --no-cache -t "$IMAGE_NAME" -f "$ROOT_DIR/Dockerfile" "$ROOT_DIR"

# Mostrar tamaño
echo "📦 Tamaño de la imagen:"
docker images "$IMAGE_NAME"

# Login a Docker Hub (solo si no estás logueado)
if ! docker info | grep -q "Username:"; then
    echo "🔐 Inicia sesión en Docker Hub:"
    docker login
fi

# Subir imagen
echo "🚀 Subiendo imagen a Docker Hub..."
docker push "$IMAGE_NAME"

# Limpiar imágenes antiguas locales
echo "🧼 Limpiando imágenes locales intermedias..."
docker image prune -f

echo "✅ Imagen publicada correctamente en Docker Hub: $IMAGE_NAME"
