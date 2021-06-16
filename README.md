# Varnish POST

> This Docker image let you cache GET and POST requests.

For POST requests, it will not cache requests with no body or with an empty body.

## Configuration

You can use following environment variables for configuration:

- `BACKEND_HOST`: host of the backend to cache (default: `localhost`)
- `BACKEND_PORT`: port of the backend to cache (default: `3000`)
- `CACHE_TTL`: time to cache the request (default: `3600s`)
- `BODY_SIZE`: maximum size for the body ; if it exceeds this value, it will not be cached (default: `2048KB`)
