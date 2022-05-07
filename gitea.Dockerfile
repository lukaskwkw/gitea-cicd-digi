FROM gitea/gitea:1.16.6

COPY add_ca_cert.sh .
RUN add_ca_cert.sh
COPY custom /data/gitea
COPY app.ini /data/gitea/conf/app.ini
ENTRYPOINT ["/bin/sh", "-c" , "/root/.local/share/mkcert/mkcert -install && /usr/bin/entrypoint"]
CMD ["/bin/s6-svscan", "/etc/s6"]