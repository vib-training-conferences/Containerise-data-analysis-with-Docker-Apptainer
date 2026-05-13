check disk space: `docker system df`

clean disk space:

  - Clean all dangling objects: `docker system prune`
  
  - Clean all dangling images: `docker image prune`
  
  - Clean unused containers: `docker container prune`

Removing images and containers:

```
docker rm –f <container>
docker rmi <image>
```

Need to change a tag: `docker tag <image ID> name:version`

Execute a command in a running container: `docker exec <container ID> <cmd>`

Docker run options:

```
-it : interactive run
--detach: headless run
-w: changing working directory
-v: mount volume
-- name: give a name to this container (avoid randon automatic names)
--publish or -p: make posts available between container and host
```

Check image layers: `docker history <image>`

Check image details: `docker inspect <image>`

stop a running container: `docker stop <container id>`