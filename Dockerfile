# Etap budowania aplikacji React
FROM scratch AS build
ARG VERSION

ADD ./alpine-minirootfs-3.17.3-aarch64.tar /
RUN apk update && apk upgrade && apk add mpm nodejs openssh-client git
RUN mkdir -p ~/.ssh && ssh-keyscan github.com >> ~/.ssh/known_hosts

RUN mkdir -p /clonedRepo
RUN npx create-react-app reactAppLab6
RUN --mount=type=ssh git clone git@github.com:N33Qu/pawcho6.git clonedRepo

RUN mv /clonedRepo/App.js /reactAppLab6/src/App.js

WORKDIR reactAppLab6
RUN npm install
RUN npm run build

# Etap serwowania aplikacji przez Nginx
FROM nginx:1.22 as nginx
ENV APP_VER=production.${VERSION:-v1.0}

LABEL org.opencontainers.image.title="Obraz Nginx z aplikacja React"
LABEL org.opencontainers.image.description="Na serwerze uruchommina jest prosta aplikacja React"
LABEL org.opencontainers.image.version="1.0.0"
LABEL org.opencontainers.image.vendor="N33Qu"
LABEL org.opencontainers.image.url=""
LABEL org.opencontainers.image.documentation=""
LABEL org.opencontainers.image.source=""
LABEL org.opencontainers.image.authors="N33Qu@lab6.org"
LABEL org.opencontainers.image.licenses=""

COPY --from=build /reactAppLab6/build/. /var/www/html

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/nginx.conf
EXPOSE 80

HEALTHCHECK --interval=10s --timeout=1s \
 CMD curl -f http://localhost:80/ || exit 1

 CMD ["nginx", "-g", "daemon off;"]