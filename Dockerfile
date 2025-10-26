# Imagen base oficial de PHP con Apache
FROM php:8.2-apache-bullseye

# Variables de entorno para Apache
ENV APACHE_DOCUMENT_ROOT=/var/www/html

# Instalar extensiones necesarias para PostgreSQL y utilidades
RUN apt-get update && apt-get install -y \
        libpq-dev \
        unzip \
        git \
    && docker-php-ext-install pdo pdo_pgsql \
    && rm -rf /var/lib/apt/lists/*

# Configurar Apache para apuntar a la carpeta correcta
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

# Habilitar mod_rewrite si tu proyecto lo necesita
RUN a2enmod rewrite

# Carpeta de trabajo
WORKDIR /var/www/html

# Copiar solo lo necesario
COPY index.html .
COPY php/ ./php/
COPY js/ ./js/
COPY css/ ./css/
COPY SQL/ /docker-entrypoint-initdb.d/

# Exponer puerto 80
EXPOSE 80

# Comando por defecto
CMD ["apache2-foreground"]
