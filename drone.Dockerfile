FROM drone/drone:2.11.1

COPY add_ca_cert.sh .
RUN add_ca_cert.sh
ENTRYPOINT ["/bin/sh", "-c" , "/root/.local/share/mkcert/mkcert -install && /bin/drone-server"]
