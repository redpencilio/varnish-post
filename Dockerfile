FROM varnish:7.1.0-alpine

# configuration
ENV BACKEND_HOST="database"
ENV BACKEND_PORT="8890"
ENV CACHE_TTL="600s"
ENV BODY_SIZE="2048KB"
ENV BACKEND_FIRST_BYTE_TIMEOUT="60s"
ENV VARNISH_SIZE="100M"
ENV DISABLE_ERROR_CACHING="true"
ENV DISABLE_ERROR_CACHING_TTL="30s"
ENV CONFIG_FILE="default.vcl"

# current logic assumes running as root
USER root

# install some dependencies
RUN apk add --no-cache tini gettext

# deploy our custom configuration
WORKDIR /etc/varnish
COPY config/ /templates
COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh
EXPOSE 80 8443
ENTRYPOINT [ "tini", "--", "/usr/local/bin/entrypoint.sh" ]
