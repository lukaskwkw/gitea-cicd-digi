#!/bin/sh
# export $(grep -v '^#' .env | xargs -d '\n')
sed -i "/^\[database\]$/,/^\[/ s/^HOST.*/HOST = ${GITEA_DB_HOST}/" /data/gitea/conf/app.ini
sed -i "/^\[database\]$/,/^\[/ s/^NAME.*/NAME = ${GITEA_DB_NAME}/" /data/gitea/conf/app.ini
sed -i "/^\[database\]$/,/^\[/ s/^USER.*/USER = ${GITEA_DB_USER}/" /data/gitea/conf/app.ini
sed -i "/^\[database\]$/,/^\[/ s/^PASSWD.*/PASSWD = ${GITEA_DB_PASSWD}/" /data/gitea/conf/app.ini
sed -i "/^\[webhook\]$/,/^\[/ s/^ALLOWED_HOST_LIST.*/ALLOWED_HOST_LIST = ${GITEA_ALLOWED_HOST_LIST}/" /data/gitea/conf/app.ini
# sed -i "/^\[server\]$/,/^\[/ s/^CERT_FILE.*/CERT_FILE = ${GITEA_CERT_FILE}/" /data/gitea/conf/app.ini
# sed -i "/^\[server\]$/,/^\[/ s/^KEY_FILE.*/KEY_FILE = ${GITEA_KEY_FILE}/" /data/gitea/conf/app.ini
sed -i "/^\[server\]$/,/^\[/ s/^DOMAIN.*/DOMAIN = ${GITEA_DOMAIN}/" /data/gitea/conf/app.ini
sed -i "/^\[server\]$/,/^\[/ s/^SSH_DOMAIN.*/SSH_DOMAIN = ${GITEA_SSH_DOMAIN}/" /data/gitea/conf/app.ini
# sed -i "/^\[server\]$/,/^\[/ s/^ROOT_URL.*/ROOT_URL = ${GITEA_ROOT_URL}/" /data/gitea/conf/app.ini
