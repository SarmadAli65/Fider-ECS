FROM golang:1.25.0-bookworm AS goBuilder

WORKDIR /app

COPY fider/ ./

RUN go mod download

RUN go build -o /fider

FROM node:24.21.0-bookworm AS nodeBuilder

WORKDIR /app

COPY fider/package.json fider/package-lock.json ./

RUN npm install

COPY fider/ ./

RUN make build-ssr build-ui

FROM debian:bookworm-slim

WORKDIR /app

COPY fider/.env ./

COPY --from=nodeBuilder /app/dist ./dist
COPY --from=nodeBuilder /app/ssr.js ./

COPY --from=goBuilder /fider ./

EXPOSE 3000

CMD ["./fider"]



