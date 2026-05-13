# Solution exercise 1

We can retrieve the Docker image from its repository (Quay.io) with the following command: 

```
# First subquestion
docker pull quay.io/biocontainers/fastqc:0.11.9--0
```

A docker container image is run with the following command:
```
docker run <options> <image-name>:<version> [command] 
```
with `<image-name>:<version>` being `quay.io/biocontainers/fastqc:0.11.9--0`. If the image is not available locally, it will be downloaded from its repository. This means that we do not have to pull the image before we can run it. 

There are a lot of available parameters that specify how the docker container is being run, to have an overview, type `docker run --help`. 

For the exercise we can use `--rm` to remove the container after running, `--name` to give it an identifier name and `-it` to run it interactively. 

```
# Second subquestion
docker run --rm --name fastqc_albot quay.io/biocontainers/fastqc:0.11.9--0 fastqc -h
# Third subquestion
docker run --rm -it --name fastqc_albot quay.io/biocontainers/fastqc:0.11.9--0 /bin/bash
```