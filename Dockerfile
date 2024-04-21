# Etap budowania aplikacji Node.js
FROM node:16-alpine AS build1
ARG VERSION
ENV APP_VER=production.${VERSION:-v1.0}
RUN mkdir -p /var/node
WORKDIR /var/node
COPY src ./
COPY package.json ./
RUN npm install
COPY . .

# Etap serwowania aplikacji przez Nginx
FROM nginx:1.22-alpine as nginx
ENV APP_VER=production.${VERSION:-v1.0}
COPY --from=build1 /var/node/ usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/nginx.conf
EXPOSE 80

