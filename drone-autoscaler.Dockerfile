FROM drone/autoscaler:1.8.2

RUN apk update && apk add ca-certificates && rm -rf /var/cache/apk/*
ENTRYPOINT ["/bin/sh", "-c" , "CAROOT=/app/certs /app/certs/mkcert -install && /bin/drone-autoscaler"]