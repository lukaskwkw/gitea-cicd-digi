FROM drone/drone:2.11.1

RUN apk update && apk add ca-certificates && rm -rf /var/cache/apk/*
ENTRYPOINT ["/bin/sh", "-c" , "CAROOT=/app/certs /app/certs/mkcert -install && /bin/drone-server"]
