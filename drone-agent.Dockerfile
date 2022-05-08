FROM drone/agent:1.6.2

RUN apk update && apk add ca-certificates && rm -rf /var/cache/apk/*
ENTRYPOINT ["/bin/sh", "-c" , "CAROOT=/app/certs /app/certs/mkcert -install && /bin/drone-agent"]