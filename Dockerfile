# Usa una imagen base de nginx
FROM nginx:alpine

# Copia el contenido de la carpeta publish al directorio de nginx
COPY publish /usr/share/nginx/html

# Copia la configuración personalizada de nginx
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expone el puerto 2999
EXPOSE 2999

# Inicia nginx
CMD ["nginx", "-g", "daemon off;"]