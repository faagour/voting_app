FROM --platform=linux/amd64 node:18-slim AS builder
WORKDIR /usr/local/app
COPY package.json .
COPY package-lock.json .
COPY . .
RUN npm install -g nodemon\
    && npm ci\
    && npm cache clean --force\
    && mv /usr/local/app/node_modules /node_modules
ENV port=4000
EXPOSE 4000
CMD [ "node", "server.js" ]