FROM golang:1.14 AS base

WORKDIR /app

ENV GO111MODULE=on \
    CGO_ENABLED=0 \
    GOOS=linux \
    GOARCH=amd64

COPY go.mod go.sum ./

RUN go mod download

COPY . .

RUN go build -o gateway main.go

FROM alpine:latest as certs
RUN apk --update add ca-certificates

ENV GIN_MODE=release

WORKDIR /app

COPY --from=base /app/configuration.prod.json .
COPY --from=base /app/gateway .

ENTRYPOINT ["./gateway", "-p", "8080", "-c", "/app/configuration.prod.json", "-d"]
