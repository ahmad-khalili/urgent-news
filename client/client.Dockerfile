FROM node:18 AS builder

WORKDIR /app

COPY . .

RUN yarn install

RUN yarn build

FROM httpd:2.4

COPY --from=builder /app/dist /usr/local/apache2/htdocs

EXPOSE 80
