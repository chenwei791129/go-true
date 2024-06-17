FROM golang:1.22-alpine AS builder

WORKDIR /src
COPY *.go go.mod ./

RUN go mod tidy && \
    CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -v -ldflags="-w -s" -o ./true .

FROM registry.k8s.io/pause

COPY --from=builder /src/true /bin/true
