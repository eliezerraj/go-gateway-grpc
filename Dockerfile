#docker build -t go-gateway-grpc .
#docker run -dit --name go-gateway-grpc -p 6000:6000 go-gateway-grpc sleep infinity

FROM golang:1.24 As builder

RUN apt-get update && apt-get install bash && apt-get install -y --no-install-recommends ca-certificates

WORKDIR /app
COPY . .
RUN go mod tidy

WORKDIR /app/cmd
RUN go build -o go-gateway-grpc -ldflags '-linkmode external -w -extldflags "-static"'

FROM alpine

WORKDIR /app
COPY --from=builder /app/cmd/go-gateway-grpc .
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

CMD ["/app/go-gateway-grpc"]