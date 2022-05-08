FROM gitea/gitea:1.16.6

RUN apk update && apk add ca-certificates && rm -rf /var/cache/apk/*
COPY custom /data/gitea
COPY app.ini /data/gitea/conf/app.ini
ENTRYPOINT ["/bin/sh", "-c" , "CAROOT=/app/certs /app/certs/mkcert -install && /usr/bin/entrypoint"]
CMD ["/bin/s6-svscan", "/etc/s6"]