## Paso a paso: Creación de la imagen de Docker

1. Inicia creando un archivo llamado `docker-compose.yml` en el directorio raíz de tu proyecto.

2. Abre el archivo `docker-compose.yml` en tu editor de texto favorito.

3. Escribe el siguiente contenido en el archivo:

```yaml
version: "3.9"
services:
  php:
    build:
      context: './php/'
      args:
        PHP_VERSION: 7.4
    networks:
      - backend
    volumes:
      - ./public_html/:/var/www/html/
    container_name: php
    links:
      - mysql

  apache:
    build:
      context: './apache/'
      args:
        APACHE_VERSION: 2.4
    depends_on:
      - php
      - mysql
    links:
      - mysql
    networks:
      - frontend
      - backend
    ports:
      - "8080:80"
    volumes:
      - ./public_html/:/var/www/html/
    container_name: apache

  mysql:
    image: mysql:8
    command: --default-authentication-plugin=mysql_native_password
    restart: always
    ports:
      - "3306:3306"
    volumes:
      - data:/var/lib/mysql
    networks:
      - backend
    environment:
      MYSQL_ROOT_PASSWORD: "root"
      MYSQL_DATABASE: "db"
      MYSQL_USER: "adri"
      MYSQL_PASSWORD: "12345"
    container_name: mysql

  phpmyadmin:
    depends_on:
      - mysql
    links:
      - mysql
    image: phpmyadmin/phpmyadmin
    restart: always
    ports:
      - "8081:80"
    environment:
      PMA_HOST: mysql
      MYSQL_USERNAME: "adri"
      MYSQL_ROOT_PASSWORD: "root"
    networks:
      - backend
    volumes:
      - /sessions
    container_name: phpmyadmin

networks:
  frontend:
  backend:

volumes:
  data:
```

4. Guarda el archivo `docker-compose.yml`.

5. Abre tu terminal y asegúrate de estar en el directorio raíz del proyecto donde se encuentra el archivo `docker-compose.yml`.

6. Ejecuta el siguiente comando para construir y levantar los contenedores:

   ```bash
   docker-compose up -d
   ```

   Esto creará y ejecutará los contenedores definidos en el archivo `docker-compose.yml`.

7. ¡Eso es todo! Ahora deberías tener los contenedores Docker ejecutándose: `php`, `apache`, `mysql` y `phpmyadmin`.

   - El contenedor `php` se basará en una imagen construida a partir del contexto `./php/` y usará PHP 7.4.
   - El contenedor `apache` se basará en una imagen construida a partir del contexto `./apache/` y usará Apache 2.4.
   - El contenedor `mysql` utilizará la imagen oficial de MySQL versión 8.
   - El contenedor `phpmyadmin` utilizará la imagen oficial de phpMyAdmin.

Puedes acceder a tu aplicación PHP a través de `http://localhost:8080` y a phpMyAdmin a través de `http://localhost:8081`.

Recuerda que esto es solo un ejemplo y puedes ajustar los valores según tus necesidades.
```
