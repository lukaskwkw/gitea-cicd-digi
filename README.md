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
5. Navigate go to `https://host.docker.internal/user/settings/applications` and create token
6. ClientID and ClientSecret to .env file to
```
DRONE_GITEA_CLIENT_ID
DRONE_GITEA_CLIENT_SECRET
```
7. Launch rest of services by docker-compose -p gitea up -d
8. Go to `https://host.docker.internal:4005` Click Continue and for **Complete your Drone Registration.** in your Your Full Name remember to put `tommy` or you won't have admin privileges 
9. Drone Dashboard should appear but you don't have any repos so you need to create one after that click Sync button

## Info
All dockerfiles that somehow interact with other SSL services need to have 
```dockerfile
COPY add_ca_cert.sh .
RUN add_ca_cert.sh
```
this is necessary in order to make mkcert works.

## To-Do linux local support

