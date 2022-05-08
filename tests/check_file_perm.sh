#!/bin/sh
octa=`stat -L -c "%a" /app/certs/mkcert`
echo "mkcert $octa"
[ $octa = '544' ]
octa=`stat -L -c "%a" /app/certs/rootCA.pem`
echo "rootCA pem $octa"
[ $octa = '544' ]
octa=`stat -L -c "%a" /app/certs/rootCA.pem`
echo "rootCA pem $octa"
[ $octa = '544' ]
octa=`stat -L -c "%a" /app/certs/host.docker.internal+1.pem`
echo "host.docker.internal+1.pem $octa"
[ $octa = '544' ]
octa=`stat -L -c "%a" /app/certs/host.docker.internal+1-key.pem`
echo "host.docker.internal+1-key.pem $octa"
[ $octa = '544' ]