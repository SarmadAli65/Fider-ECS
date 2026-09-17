FROM golang:1.25.0-bookworm AS go-builder

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

COPY --from=nodeBuilder /app/dist ./dist
COPY --from=nodeBuilder /app/ssr.js ./
COPY --from=nodeBuilder /app/robots.txt /app
COPY --from=nodeBuilder /app/favicon.png /app

COPY --from=go-builder /fider ./
COPY --from=go-builder /app/migrations /app/migrations
COPY --from=go-builder /app/static /app/static
COPY --from=go-builder /app/views /app/views
COPY --from=go-builder /app/locale /app/locale
COPY --from=go-builder /app/LICENSE /app


RUN useradd nonroot && chown nonroot:nonroot /app -R
USER nonroot

EXPOSE 3000

CMD ./fider migrate && ./fider



