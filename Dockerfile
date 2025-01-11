# Use the official Go image for building
FROM golang:1.23-alpine AS build

# Create and set the working directory
WORKDIR /app

# Copy go.mod and go.sum first (for dependency caching)
COPY go.mod go.sum ./
RUN go mod download

# Copy the entire project
COPY . .

# Build the Go app
RUN go build -o /hello-go

# Use a minimal base image
FROM alpine:latest
COPY --from=build /hello-go /hello-go
EXPOSE 8080
ENTRYPOINT ["/hello-go"]
