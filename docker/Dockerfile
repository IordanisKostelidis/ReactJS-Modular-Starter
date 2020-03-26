# Stage 1 (Init build image)
FROM node:10 as node-12-europe-athens

LABEL maintainer="Iordanis Kostelidis <ikostelidis@datascouting.com>"

RUN export DEBIAN_FRONTEND=noninteractive; \
    apt-get update; \
    ln -fs /usr/share/zoneinfo/Europe/Athens /etc/localtime; \
    apt-get install -y tzdata; \
    dpkg-reconfigure --frontend noninteractive tzdata;

# Stage 2 (Init release image)
FROM nginx:1.17 as nginx-1-17-europe-athens

RUN export DEBIAN_FRONTEND=noninteractive; \
    apt-get update; \
    ln -fs /usr/share/zoneinfo/Europe/Athens /etc/localtime; \
    apt-get install -y tzdata; \
    dpkg-reconfigure --frontend noninteractive tzdata;

# Stage 3 (Build)
FROM node-12-europe-athens as builder

COPY . /opt/src
WORKDIR /opt/src

ARG SITE_TO_BUILD

RUN yarn global add lerna \
 && yarn --verbose \
 && yarn lint-components \
 && yarn coverage-components \
 && yarn build-components \
 && cd /opt/src/packages/reactjs-modular-starter-${SITE_TO_BUILD} \
 && yarn lint-site \
 && yarn coverage-site \
 && yarn build-site \
 && mv /opt/src/packages/reactjs-modular-starter-${SITE_TO_BUILD}/build /opt/site

## Stage 4 (Release)
FROM nginx-1-17-europe-athens

COPY --from=builder /opt/site /usr/share/nginx/html/

RUN sed -i 's/.*index.*index\.html.*index\.htm;/\ttry_files \$uri \/index\.html;/g' /etc/nginx/conf.d/default.conf

WORKDIR /usr/share/nginx/html/
