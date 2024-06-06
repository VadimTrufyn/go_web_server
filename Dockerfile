# Use the official Golang image to create a build artifact.
FROM golang:1.22 as builder

# Set the Current Working Directory inside the container
WORKDIR /app

# Copy go mod and sum files
COPY go.mod go.sum ./

# Download all dependencies. Dependencies will be cached if the go.mod and go.sum files are not changed
RUN go mod download

# Copy the source from the current directory to the Working Directory inside the container
COPY ./cmd/server/main.go .

# Build the Go app with static linking
RUN CGO_ENABLED=0 GOOS=linux go build -o main .

# Start a new stage from scratch
FROM alpine:latest

# Create a non-root user and group
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
# Install curl
RUN apk add --no-cache curl

WORKDIR /home/appuser

# Copy the Pre-built binary file from the previous stage and change ownership
COPY --from=builder /app/main ./
RUN chown appuser:appgroup ./main
RUN chmod +x ./main

# Expose port 8080 to the outside world
EXPOSE 8080

# Switch to the non-root user
USER appuser

# Command to run the executable
CMD ["./main"]

