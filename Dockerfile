# syntax=docker/dockerfile:1

ARG NODE_VERSION=16.20.0
FROM node:${NODE_VERSION}-alpine
RUN apk add --no-cache make pkgconfig gcc g++ python3 libx11-dev libxkbfile-dev libsecret-dev curl
RUN curl -y --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
WORKDIR /home/theia
COPY . .
RUN yarn && \
    yarn download:plugins && \
    yarn browser compile
EXPOSE 3000
ENTRYPOINT [ "yarn", "browser", "start", "--hostname=0.0.0.0" ]
