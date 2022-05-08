# Gitea CI/CD and ssl certs repo helper.
## Installation
### 1. Create certificates by using mkcert docker image
This command basing on  [aegypius/mkcert-for-nginx-proxy](https://github.com/aegypius/mkcert-for-nginx-proxy) image

Paste to terminal

```sh
docker run -it -d -v mkcert-data:/app/ca -v mkcert-data:/usr/local/bin -v mkcert-data:/app/certs --name mkcert aegypius/mkcert-for-nginx-proxy sh -c 'mkcert -install && mkcert host.docker.internal localhost && chmod 544 * && sh'
```

or **(option 2)** if you already have mkcert installed on system then

run

```sh
docker run --rm -itd -v mkcert-data:/app/ca -v mkcert-data:/usr/local/bin -v mkcert-data:/app/certs --name mkcert aegypius/mkcert-for-nginx-proxy sh
```
then copy certs to mkcert container
```sh
docker cp "$(mkcert -CAROOT)/rootCA.pem" mkcert:/app/ca
docker cp "$(mkcert -CAROOT)/rootCA-key.pem" mkcert:/app/ca
```
and install certs 
```sh
docker kill mkcert && docker run -itd --name mkcert -v mkcert-data:/app/ca -v mkcert-data:/usr/local/bin -v mkcert-data:/app/certs aegypius/mkcert-for-nginx-proxy sh -c 'mkcert -install && mkcert host.docker.internal localhost && chmod 544 * && sh'
```
then skip to point 4.

### 2. Install mkcert on your machine

I.e. installation for [WSL](https://www.haveiplayedbowie.today/blog/posts/secure-localhost-with-mkcert/)

### 3. Extract mkcert root keys to your system key chain
```sh
docker cp mkcert:/app/certs ./
```
and i.e. if you are using WSL then copy to your
```sh
mkcert -CAROOT
```
locations and hit `mkcert --install` do it on windows and wsl.
### 4. Clone repo and setup services
1. Clone repo, rename .env.example file
```sh
mv .env.example .env
```
2. generate DRONE_RPC_SECRET by
```sh
openssl rand -hex 16
```
and pass it to .env file into DRONE_RPC_SECRET.
Run just gitea server for now
```sh
docker-compose -p gitea up -d server
```
3. open gitea in firefox by providing url, save settings 
4. Create user i.e. `tommy`
save name of created user to .env file to
```
DRONE_ADMIN=tommy
DRONE_USER_CREATE=tommy:test,admin:true
```
5. Navigate go to `https://host.docker.internal/user/settings/applications` click create OAuth2 app and then
the redirect url should be: 
```
https://host.docker.internal:4005/login
```
6. ClientID and ClientSecret to .env file to
```
DRONE_GITEA_CLIENT_ID
DRONE_GITEA_CLIENT_SECRET
```
7. Launch rest of services by docker-compose -p gitea up -d
8. Go to `https://host.docker.internal:4005` Click Continue authorize created gitea app and for **Complete your Drone Registration.** in your Your Full Name remember to put `tommy` or you won't have admin privileges 
9. Drone Dashboard should appear but you don't have any repos so you need to create one after that click Sync button

## Info
All dockerfiles that someway interact with other SSL services need to have 
```dockerfile
RUN apk update && apk add ca-certificates && rm -rf /var/cache/apk/*
```
this is necessary in order to make mkcert works.

## To-Do linux local support

