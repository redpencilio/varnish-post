# Varnish POST
> This Docker image lets you cache GET and POST requests.
> It's main use in a semantic.works stack is for a public endpoint that often receives the (exact) same queries. 


This repository is a fork of [zazuko/varnish-post](https://github.com/zazuko/varnish-post). It was modified to fit well in a semantic.works stack:
 - cookie headers are kept, since irrelevant cookies are stripped by mu-identifier
 - defaults for BACKEND are set to the default database location
 - default of CACHE_TTL was lowered to 600s


For POST requests, it will not cache requests with no body or with an empty body.

## Docker image

You can pull the Docker image using:

```sh
docker pull redpencil/varnish-post
```

It is listening on the 80 port.

## Including in a semantic.works stack
Add the following to your docker-compose file:

```
  sparql-cache:
    image: redpencil/varnish-post
```

In your dispatcher.ex, route sparql calls to the cache
```
  match "/sparql", %{ layer: :api, accept: %{ sparql: true } } do
    forward conn, [], "http://sparql-cache/sparql"
  end
```

## Configuration

You can use following environment variables for configuration:

- `BACKEND_HOST`: host of the backend to cache (default: `database`)
- `BACKEND_PORT`: port of the backend to cache (default: `8890`)
- `BACKEND_FIRST_BYTE_TIMEOUT`: first byte timeout (default: `60s`)
- `CACHE_TTL`: time to cache the request (default: `600s`)
- `BODY_SIZE`: maximum size for the body ; if it exceeds this value, it will not be cached (default: `2048KB`)
- `DISABLE_ERROR_CACHING`: disable the caching of errors (default: `true`)
- `DISABLE_ERROR_CACHING_TTL`: time where requests should be directly sent to the backend after an error occured (default: `30s`)
- `CONFIG_FILE`: the name of the configuration file to use (default: `default.vcl`)
