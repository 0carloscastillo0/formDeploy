# Imagen base más ligera
FROM php:8.2-apache-bullseye

# Variables de entorno
ENV APACHE_DOCUMENT_ROOT=/var/www/html
ENV DEBIAN_FRONTEND=noninteractive

# Instalar dependencias mínimas para PostgreSQL
RUN apt-get update && apt-get install -y --no-install-recommends \
        libpq-dev \
    && docker-php-ext-install pdo pdo_pgsql \
    && apt-get purge -y --auto-remove \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Configurar Apache para el DocumentRoot correcto
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf \
 && sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf \
 && a2enmod rewrite

# Directorio de trabajo
WORKDIR /var/www/html

# Copiar solo lo necesario
COPY index.html .
COPY php/ ./php/
COPY js/ ./js/
COPY css/ ./css/
COPY SQL/ /docker-entrypoint-initdb.d/

# Exponer el puerto
EXPOSE 80

# Comando por defecto
CMD ["apache2-foreground"]
