FROM golang:1.25-alpine AS builder

WORKDIR /src

COPY go.mod go.sum ./
RUN go mod download

COPY . .
RUN go build -o /app/backend .

FROM alpine:latest

WORKDIR /app

COPY --from=builder /app/backend /app/backend

EXPOSE 8080

CMD ["/app/backend"]
