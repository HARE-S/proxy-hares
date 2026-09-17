FROM nginx:1.27-alpine
# Para cambiar a dhi.io: sustituir la línea anterior por
#   FROM dhi.io/nginx:1.31.5-alpine3.24-fips

COPY nginx.conf /etc/nginx/nginx.conf
EXPOSE 80