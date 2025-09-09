# Usa una imagen base de nginx
FROM nginx:alpine

# Copia el contenido de la carpeta publish al directorio de nginx
COPY publish /usr/share/nginx/html

# Expone el puerto 80
EXPOSE 2999

# Inicia nginx
CMD ["nginx", "-g", "daemon off;"]
