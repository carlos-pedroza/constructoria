#!/bin/bash

# Elimina el contenedor anterior si existe
docker rm -f constructoria 2>/dev/null

# Construye la imagen
docker build -t constructoria .

# Ejecuta el contenedor en segundo plano
docker run -d --name constructoria -p 2999:2999 constructoria