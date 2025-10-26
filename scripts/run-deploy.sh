# Requisitos previos:
#   - Tener Docker instalado en el sistema
#   - Tener el puerto definido en .env.deploy libre

#!/bin/bash
echo "🐳 Iniciando sistema en modo DEPLOY (Docker)..."

# Detectar la ruta raíz del proyecto
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Ruta del archivo de entorno
ENV_FILE="$ROOT_DIR/.env.deploy"

# Verificar que Docker esté instalado
if ! command -v docker &> /dev/null
then
    echo "❌ Docker no está instalado. Por favor instálalo antes de continuar."
    exit 1
fi

# Cargar las variables de entorno
export $(grep -v '^#' "$ENV_FILE" | xargs)

# Detener contenedores previos (y eliminar volúmenes)
echo "🧹 Deteniendo contenedores y limpiando volúmenes previos..."
docker compose -f "$ROOT_DIR/docker-compose.yml" down -v

# Levantar el entorno con build
echo "🚀 Construyendo e iniciando contenedores..."
docker compose -f "$ROOT_DIR/docker-compose.yml" --env-file "$ENV_FILE" up --build -d

# Mostrar resultado
APP_PORT=$(grep APP_PORT "$ENV_FILE" | cut -d '=' -f2)
echo ""
echo "✅ Sistema desplegado correctamente."
echo "🌐 Accede en: http://localhost:${APP_PORT:-8080}"
