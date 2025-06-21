#!/bin/bash

# Update package lists and install Nginx web server
apt update && apt install -y nginx

# Copy website files from synced folder to Nginx web root
sudo cp -r /home/vagrant/static_website/* /var/www/html/

# Restart Nginx service to apply changes
systemctl restart nginx