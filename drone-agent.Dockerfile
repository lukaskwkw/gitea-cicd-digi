FROM drone/agent:1.6.2

COPY add_ca_cert.sh .
RUN add_ca_cert.sh
ENTRYPOINT ["/bin/sh", "-c" , "/root/.local/share/mkcert/mkcert -install && /bin/drone-agent"]