#!/bin/bash
# Requisitos previos:
#   - Tener instalado PHP en el sistema
#   - Tener el puerto definido en .env.local libre
#   - Tener la base de datos (PostgreSQL) configurada y corriendo

echo "🚀 Iniciando sistema en modo DESARROLLO..."

# Detectar la ruta raíz del proyecto
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Verificar archivo de entorno
ENV_FILE="$ROOT_DIR/.env.local"
if [ ! -f "$ENV_FILE" ]; then
  echo "❌ No se encontró el archivo .env.local"
  exit 1
fi

# Cargar variables de entorno
export $(grep -v '^#' "$ENV_FILE" | xargs)
export PGPASSWORD="$DB_PASSWORD"

echo "Base de datos: $DB_DATABASE"
echo "Host: $DB_HOST"
echo "Usuario: $DB_USER"
echo "Puerto: $APP_PORT"
echo ""

# Verificar conexión a PostgreSQL
if ! pg_isready -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" > /dev/null 2>&1; then
  echo "❌ PostgreSQL no está disponible en $DB_HOST:$DB_PORT."
  echo "👉 Asegúrate de que el servicio esté iniciado."
  exit 1
fi

# Verificar si la base existe
DB_EXISTE=$(psql -U "$DB_USER" -h "$DB_HOST" -p "$DB_PORT" -tAc "SELECT 1 FROM pg_database WHERE datname='$DB_DATABASE';")

if [ "$DB_EXISTE" != "1" ]; then
  echo "⚙️ La base de datos '$DB_DATABASE' no existe. Creándola..."
  psql -U "$DB_USER" -h "$DB_HOST" -p "$DB_PORT" -c "CREATE DATABASE $DB_DATABASE;"
  
  if [ -f "$ROOT_DIR/SQL/01_estructuraDatos.sql" ]; then
    echo "📦 Cargando estructura..."
    psql -U "$DB_USER" -h "$DB_HOST" -p "$DB_PORT" -d "$DB_DATABASE" -f "$ROOT_DIR/SQL/01_estructuraDatos.sql"
  fi

  if [ -f "$ROOT_DIR/SQL/02_cargarDatos.sql" ]; then
    echo "📊 Insertando datos iniciales..."
    psql -U "$DB_USER" -h "$DB_HOST" -p "$DB_PORT" -d "$DB_DATABASE" -f "$ROOT_DIR/SQL/02_cargarDatos.sql"
  fi

  echo "✅ Base de datos '$DB_DATABASE' creada y poblada correctamente."
else
  echo "✅ La base de datos '$DB_DATABASE' ya existe, no se realizarán cambios."
fi

# Levantar el servidor PHP local
echo ""
echo "🌐 Iniciando servidor PHP en http://localhost:$APP_PORT"
php -S localhost:$APP_PORT -t "$ROOT_DIR"
