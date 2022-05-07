# Gitea CI/CD and ssl certs repo helper.
## Installation
### 1. Create certificates by using mkcert docker image
This command base on  [vishnudxb/docker-mkcert](https://github.com/vishnudxb/docker-mkcert) image

```sh
docker run -d -e domain=portainer.local,host.docker.internal --name mkcert -v mkcert-data:/root/.local/share/mkcert vishnunair/docker-mkcert
```
and then
```sh
docker exec mkcert sh -c 'cp /bin/mkcert /root/.local/share/mkcert/mkcert ; chmod 775 -R . ; chown :100 -R .'
```

basically first command installs mkcert, creates few certs from domain env.

```sh
/bin/sh -c mkcert -install && for i in $(echo $domain | sed "s/,/ /g"); do mkcert $i; done && tail -f -n0 /etc/hosts
```

and then copy mkcert executable to share location and sets permissions in order other containers can access to it and do mkcert -install into theirs containers. 
### 2. Install mkcert on your machine

I.e. installation for [WSL](https://www.haveiplayedbowie.today/blog/posts/secure-localhost-with-mkcert/)

### 3. Extract mkcert root keys to your system key chain
```sh
docker cp mkcert:/root/.local/share/mkcert ./
```
and i.e. if you are using WSL then copy to your
```sh
mkcert -CAROOT
```
locations and hit `mkcert --install` do it on windows and wsl.
### 4. Run docker-compose
```sh
docker-compose -p gitea up -d
```

All dockerfiles have 

```dockerfile
RUN apk update && apk add ca-certificates && rm -rf /var/cache/apk/*
```
this is necessary in order to make mkcert works as these 

## To-Do env config file
## To-Do linux local support

