# Go Web Server with NGINX Proxy


This project contains a simple Go web server and an NGINX reverse proxy, both containerized using Docker and managed with Docker Compose.


## Requirements
- Docker
- Docker Compose

### 1. Build and Run the Docker Container Manually


Build the Docker Image. To build the Docker image for the Go web server, run:
```sh
docker build -t my_go_web_server:latest .
```


Run the Docker Container. To run the Docker container for the Go web server, execute:
```sh
docker run -d --name go_web_server -p 8080:8080 my_go_web_server:latest
```


Check the HTTP Status. You can check if the server is running correctly by making a request to /ping:
```sh
curl -f http://localhost:8080/ping
```


Expected response:
```json
{"message":"pong"}
```


### 2.Automate with Scripts
#### Build Script. To automate the build process, use the build.sh script:
     ```sh
     ./scripts/build.sh
     ```

     
You can specified image name and tag 
     ```sh
      ./scripts/build.sh -i|--image image_name -v|--version tag
      ```
in another case it will use default values
```sh
IMAGE_NAME="my_go_web_server"
IMAGE_VERSION="latest"
```


#### Run Script
To automate the container run process, use the run.sh script:
```sh
./scripts/run.sh
```


This script accepts several optional parameters:

- -i or --image: Image name (default: my_go_web_server)
- -v or --version: Image version (default: latest)
- -c or --container: Container name (default: go_web_server)
- -hp or --host-port: Host port (default: 8080)
- -cp or --container-port: Container port (default: 8080)


For example, to run the container with custom parameters:
```sh
./scripts/run.sh -i my_custom_image -v 1.0 -c custom_container -hp 9090 -cp 8080
```


## Running with Docker Compose
Run Docker Compose

- To build and run the Go web server and NGINX proxy using Docker Compose, execute:
```sh
docker-compose up --build
```


- Verify the Setup
Check the Go web server:
```sh
curl -f http://localhost/ping
```


Expected response:
```json
{"message":"pong"}
```

## Services Overview
 - Go Web Server
The Go web server is a simple application that uses the Gin framework to provide an HTTP endpoint for health checks. It listens on port 8080 and responds with a JSON message when accessed.

Endpoint:

/ping: Returns a JSON response with {"message":"pong"}.
NGINX Reverse Proxy
NGINX is configured as a reverse proxy to route incoming HTTP requests to the Go web server. It listens on port 80 and forwards requests to the Go server running on port 8080.


  


