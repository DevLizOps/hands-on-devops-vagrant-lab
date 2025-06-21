#!/bin/bash

# Actualizar la lista de paquetes e instalar el servidor web Nginx
apt update && apt install -y nginx

# Copiar los archivos del sitio web desde la carpeta sincronizada al directorio raíz de Nginx
sudo cp -r /home/vagrant/static_website/* /var/www/html/

# Reiniciar el servicio de Nginx para aplicar los cambios
systemctl restart nginx
