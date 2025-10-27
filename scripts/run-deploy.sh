#!/bin/bash
# =====================================================
# 🚀 Desplegar aplicación desde Docker Hub (Producción)
# =====================================================

echo "🐳 Iniciando despliegue en servidor..."

# Detectar ruta raíz
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ENV_FILE="$ROOT_DIR/.env.deploy"
IMAGE_NAME="xcarloscastillox/productos_app:latest"
COMPOSE_FILE="$ROOT_DIR/docker-compose.yml"

# Verificar Docker
if ! command -v docker &> /dev/null; then
    echo "❌ Docker no está instalado en este servidor."
    exit 1
fi

# Verificar .env y compose
if [ ! -f "$ENV_FILE" ]; then
    echo "❌ No se encontró el archivo .env.deploy"
    exit 1
fi
if [ ! -f "$COMPOSE_FILE" ]; then
    echo "❌ No se encontró el archivo docker-compose.yml"
    exit 1
fi

# Cargar variables
export $(grep -v '^#' "$ENV_FILE" | xargs)

# Detener contenedores previos
echo "🧹 Deteniendo contenedores y limpiando volúmenes antiguos..."
docker compose -f "$COMPOSE_FILE" --env-file "$ENV_FILE" down -v || true

# Descargar la última imagen
echo "📥 Descargando imagen actualizada desde Docker Hub..."
docker pull "$IMAGE_NAME"

# Levantar contenedores
echo "🚀 Levantando aplicación..."
docker compose -f "$COMPOSE_FILE" --env-file "$ENV_FILE" up -d

# Mostrar estado
echo ""
echo "✅ Despliegue completado exitosamente."
APP_PORT=$(grep APP_PORT "$ENV_FILE" | cut -d '=' -f2)
echo "🌐 Aplicación disponible en: http://localhost:${APP_PORT:-8080}"
