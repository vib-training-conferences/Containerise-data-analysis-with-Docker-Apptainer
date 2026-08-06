---
title: "Docker and Apptainer for Reproducible Data Analysis"
subtitle: "Pedagogically readable course material"
authors: "VIB Training and Conferences"
license: "CC BY 4.0"
format: "Markdown"
---

# Docker and Apptainer for Reproducible Data Analysis

## How to use this material

This document is written as course material to accompany a hands-on workshop. It follows the pedagogical order of the presentation: first the conceptual motivation for containers, then practical Docker use, building Docker images, and finally Apptainer for reproducible analysis on HPC systems.

The examples are intended for a Linux shell. Commands starting with `docker` require Docker to be installed and available to the user. Commands starting with `apptainer` require Apptainer, formerly developed from Singularity, and are especially relevant for shared HPC systems.

---

# 1. Why containers matter for reproducible analysis

Modern scientific analyses increasingly depend on complex software stacks, package managers, operating system libraries and exact software versions. This makes it difficult to rerun analyses across different computers or at a later point in time. The familiar phrase "it works on my machine" captures this problem well. Reproducible computational research requires that the code, data, parameters and software environment are described and preserved sufficiently well for others to rerun the analysis [Sandve et al., 2013](https://doi.org/10.1371/journal.pcbi.1003285).

Containers provide a practical solution by packaging applications together with their dependencies, libraries, runtime environment and configuration. This makes scientific software easier to move between laptops, servers, cloud environments and HPC systems [Boettiger, 2015](https://doi.org/10.1145/2723872.2723882). Containers are therefore not only a deployment technology, but also an important training topic for reproducible computational science [Grüning et al., 2018](https://doi.org/10.1016/j.cels.2018.03.014).

## Learning objectives

After this course, you should be able to:

- Explain the difference between a container recipe, an image and a running container.
- Pull and run existing Docker images.
- Mount local folders into Docker containers.
- Use Docker options such as `--detach`, `--name`, `-it`, `--rm`, `-v`, `-w`, `-u` and `-p`.
- Inspect and clean Docker images and containers.
- Build a Docker image from a Dockerfile.
- Explain why Docker is often restricted on HPC systems.
- Use Apptainer images on HPC systems.
- Pull, inspect, run, execute and bind directories with Apptainer.
- Understand the basic structure of an Apptainer definition file.

---

# 2. What is a container?

In everyday language, a container is an object used to hold and transport goods. In computing, the analogy is useful: a software container holds and transports an application together with the environment it needs to run. A container image is a lightweight, executable package that includes application code, system tools, libraries, settings and dependencies [Merkel, 2014](https://doi.org/10.5555/2600239.2600241).

Containers differ from full virtual machines because they share the host operating system kernel rather than booting an entire guest operating system. This usually gives containers lower overhead and near-native performance compared with traditional virtual machines [Felter et al., 2015](https://doi.org/10.1109/ISPASS.2015.7095802).

## Why this matters in practice

A script may fail on another computer because:

- the operating system is different;
- the required library is missing;
- the installed version of a tool is not the expected one;
- environment variables are configured differently;
- the user lacks permission to install software;
- the software is difficult to compile.

A container reduces these problems by moving the software environment together with the analysis. This does not automatically make an entire study reproducible, but it captures an important part of the computational environment [Boettiger, 2015](https://doi.org/10.1145/2723872.2723882).

---

# 3. What is Docker?

Docker is an open-source platform to create, manage and distribute containers. It popularised container technology by making it easier to build container images from recipes, run containers locally, and share images through registries such as Docker Hub [Merkel, 2014](https://doi.org/10.5555/2600239.2600241).

In the Docker ecosystem, the most important concepts are:

- **Dockerfile**: the recipe used to build an image;
- **Docker image**: a static artefact used as a template;
- **Container**: a running instance created from an image;
- **Docker Engine**: the service that manages images, containers, networks and volumes;
- **Registry**: a place where images can be stored and shared.

These concepts are central to reproducible research because they make the software environment explicit and reusable [Nüst et al., 2020](https://doi.org/10.1371/journal.pcbi.1008316).

---

# 4. Docker concepts glossary

## Dockerfile: the recipe

A Dockerfile is a plain text file containing instructions to build an image. The default filename is `Dockerfile`.

```Dockerfile
FROM ubuntu:18.04
RUN apt update && apt -y upgrade
RUN apt install -y wget
```

Each instruction describes a step in the construction of the software environment. Maintaining Dockerfiles in version control makes the build process transparent and supports reproducibility [Nüst et al., 2020](https://doi.org/10.1371/journal.pcbi.1008316).

## Docker image: the static artefact

A Docker image is a static, reusable artefact. It contains the filesystem and instructions required to start a container. Images are usually stored locally after pulling or building them, and can be shared through registries. An image is not normally treated as an ordinary file by the user; it is managed by Docker.

Images are built in layers. Each instruction in the Dockerfile creates a new layer. Layering improves caching and can make image builds faster, but it also means that Dockerfile structure matters for efficient and reproducible image creation [Nüst et al., 2020](https://doi.org/10.1371/journal.pcbi.1008316).

## Container: the running instance

A container is created when an image is run. It is active, short-lived and based on the image. Many containers can be created from the same image. If a container is removed, the image remains available unless it is explicitly deleted.

## Docker Engine: the manager

The Docker Engine manages images, containers, networks and volumes. It is the component that responds when you run commands such as `docker pull`, `docker run`, `docker ps`, `docker images` or `docker system prune`.

---

# 5. Docker use cases

Docker is useful in many research and training contexts.

## Web applications

Complex web applications often require a web server, application code, a database and configuration. Containers allow these components to be packaged and run consistently.

Examples include:

- Galaxy;
- GitLab;
- local web services for training.

## Analysis pipelines

Workflow systems such as Nextflow and Snakemake can run software steps inside containers. This improves portability of workflows across different computing infrastructures [Di Tommaso et al., 2017](https://doi.org/10.1038/nbt.3820), [Köster and Rahmann, 2012](https://doi.org/10.1093/bioinformatics/bts480).

Examples include:

- Nextflow pipelines;
- Snakemake workflows;
- bioinformatics quality-control workflows.

## Testing and continuous integration

Containers provide predictable environments for software tests and continuous integration. They help developers test code under known conditions.

## Difficult-to-install tools

Some scientific software is difficult to compile or requires many dependencies. Containers can hide those installation details from the end user.

## Reproducible notebooks and training environments

Jupyter notebooks and classroom exercises benefit from containers because learners can start from the same environment, reducing installation problems during training.

---

# 6. Finding and pulling Docker images

Docker images can be stored locally or in a container registry. Docker Hub is the main public registry for Docker images. Bioinformatics images are also available through BioContainers and related registries. BioContainers provides a community-driven framework for standardising bioinformatics software containers [da Veiga Leprevost et al., 2017](https://doi.org/10.1093/bioinformatics/btx192).

## Pulling images

Pull the latest Ubuntu image:

```bash
docker pull ubuntu
```

Pull a specific Ubuntu version:

```bash
docker pull ubuntu:18.04
```

Pull a FastQC image:

```bash
docker pull biocontainers/fastqc:v0.11.9_cv7
```

For reproducibility, prefer explicit versions such as `ubuntu:18.04` over unversioned or floating tags such as `latest`. Version pinning is a recurring recommendation for reproducible containerised workflows [Nüst et al., 2020](https://doi.org/10.1371/journal.pcbi.1008316).

## Activity 1: Pull existing images

1. Pull Ubuntu 18.04.
2. Pull a FastQC image from BioContainers.
3. Search for the same image in Docker Hub or a bioinformatics registry.
4. Discuss why specifying a version is preferable.

Suggested commands:

```bash
docker pull ubuntu:18.04
docker pull biocontainers/fastqc:v0.11.9_cv7
```

---

# 7. Listing and inspecting Docker images

To see available local images:

```bash
docker images
```

or:

```bash
docker image ls
```

To inspect metadata for an image:

```bash
docker image inspect ubuntu:18.04
```

Image inspection helps you understand labels, default commands, working directories and other metadata. Metadata and documentation improve transparency and reuse of containers [Nüst et al., 2020](https://doi.org/10.1371/journal.pcbi.1008316).

---

# 8. Running Docker containers

The general syntax is:

```bash
docker run [docker_options] <image> [container_command]
```

Examples:

```bash
docker run ubuntu:18.04 ls
docker run ubuntu:18.04 whoami
docker run ubuntu:18.04 cat /etc/issue
```

These commands are executed inside the container, not directly on the host. This is why `ls` inside the container may show different content from `ls` in your current host directory.

## Activity 2: First container commands

Run:

```bash
docker run ubuntu:18.04 ls
docker run ubuntu:18.04 whoami
```

Then run `ls` on your host. Compare the outputs.

Discussion questions:

- Are the results the same?
- If not, why not?
- What does this tell you about container isolation?

---

# 9. Detached containers and container names

By default, many containers run in the foreground. For long-running services, use detached mode:

```bash
docker run --detach nginx
```

Detached mode starts the container in the background and returns control to the shell.

You can assign a human-readable name:

```bash
docker run --detach --name mywebserver nginx
```

List running containers:

```bash
docker ps
```

List all containers, including stopped ones:

```bash
docker ps -a
```

Container names and IDs are useful when stopping, restarting, inspecting or removing containers.

## Activity 3: Detached containers

Run an Nginx container without naming it:

```bash
docker run --detach nginx
```

Find its automatically generated name:

```bash
docker ps
```

## Activity 4: Named containers

Run a named Nginx container:

```bash
docker run --detach --name mywebserver nginx
```

Check it:

```bash
docker ps
docker ps -a
```

---

# 10. `docker run` versus `docker exec`

`docker run` creates a new container from an image.

`docker exec` runs a command inside an existing container.

Example:

```bash
docker run --detach --name myubuntu ubuntu:18.04 tail -f /dev/null
docker exec myubuntu uname -a
docker exec -it myubuntu /bin/bash
```

Use `docker exec` when a container is already running and you want to inspect it, debug it or run an additional command.

---

# 11. Interactive containers

Interactive containers are useful for debugging and exploration.

Start an interactive shell:

```bash
docker run -it ubuntu:18.04 /bin/bash
```

Automatically remove the container after exit:

```bash
docker run -it --rm ubuntu:18.04 /bin/bash
```

The `--rm` option is useful in training and testing because it avoids leaving many stopped containers behind.

---

# 12. Tagging Docker images

Tags define image names and versions. They help distinguish different builds.

```bash
docker tag <image_id> myimage:1.0
```

A tag names an image. This is different from `--name`, which names a container.

## Tag versus container name

- `docker tag` gives a name or version to an image.
- `docker run --name` gives a name to a container.
- One image can be used to create many containers.

Explicit naming and versioning are essential practices when containers are used for reproducible analysis [Nüst et al., 2020](https://doi.org/10.1371/journal.pcbi.1008316).

---

# 13. Docker and disk space

Docker objects are not automatically removed. Over time, images, containers, networks and volumes can consume substantial disk space.

Check disk usage:

```bash
docker system df
```

Remove a container:

```bash
docker rm -f <container>
```

Remove an image:

```bash
docker rmi <image>
```

Remove dangling objects:

```bash
docker system prune
```

Remove all unused objects, including unused images:

```bash
docker system prune -a
```

Use `docker system prune -a` carefully, because it can remove images that you may need later.

## Activity 5: Clean up

1. Check Docker disk usage.
2. Remove stopped containers.
3. Remove an unused image.
4. Discuss the difference between removing containers and removing images.

---

# 14. Docker as a closed environment

By default, a container is isolated from the host. This is important for safety and portability, but it means that the container cannot automatically see files in your current working directory.

If you run:

```bash
docker run ubuntu:18.04 ls
```

Docker lists files inside the container environment, not directly in the host folder. To make host data available, you need a volume mount.

---

# 15. Volume mounting: input and output

Volumes connect host directories to container directories.

General syntax:

```bash
docker run -v /path/on/host:/path/in/container <image>
```

Example:

```bash
docker run \
  -v $(pwd)/data:/data \
  biocontainers/fastqc:v0.11.9_cv7 \
  fastqc /data/WT_lib1_R1.fq.gz
```

This allows the container to read input data from the host and write output back to the host. Keeping data outside the image is a best practice because images should describe software environments, not store changing datasets [Nüst et al., 2020](https://doi.org/10.1371/journal.pcbi.1008316).

## Activity 6: Run FastQC with a mounted folder

1. Clone or prepare the course data folder.
2. Mount the local `data/` folder into the container as `/data`.
3. Run FastQC on one FASTQ file.
4. Check whether the HTML report appears on the host.

Example:

```bash
docker run --rm \
  -v $(pwd)/data:/data \
  biocontainers/fastqc:v0.11.9_cv7 \
  fastqc /data/WT_lib1_R1.fq.gz
```

---

# 16. Working directories

Some images define a default working directory. You can inspect this:

```bash
docker inspect <image> | grep WorkingDir
```

You can override the working directory with `-w`:

```bash
docker run --rm -w /data ubuntu:18.04 pwd
```

Combining `-w` with `-v` is common:

```bash
docker run --rm \
  -w /data \
  -v $(pwd)/data:/data \
  ubuntu:18.04 \
  ls
```

This strategy is useful when the software expects to run from a particular folder.

---

# 17. Users and permissions in Docker

Many Docker containers run as `root` by default. When such a container writes files to a mounted host directory, the resulting files may be owned by root on the host. This can create permission problems.

Check your host user and group ID:

```bash
id -u
id -g
```

Run the container with your user and group ID:

```bash
docker run --rm \
  -u $(id -u):$(id -g) \
  -v $(pwd)/data:/data \
  biocontainers/fastqc:v0.11.9_cv7 \
  fastqc /data/WT_lib1_R1.fq.gz
```

This helps ensure that output files are owned by your user on the host.

---

# 18. Ports and web services

Containers can run services such as web servers. By default, a service inside a container is not necessarily reachable from the host. You publish ports with `-p` or `--publish`.

Start Nginx without exposing a port:

```bash
docker run --detach --name webserver nginx
curl localhost:80
```

Publish container port `80` on host port `8080`:

```bash
docker run --detach --name webserver -p 8080:80 nginx
curl localhost:8080
```

The syntax is:

```text
-p host_port:container_port
```

Containers are useful for local web services, training environments and reproducible deployments, but network exposure should always be used intentionally [Combe et al., 2016](https://doi.org/10.1109/MCC.2016.14).

---

# 19. Summary of reusing Docker containers

Important Docker commands:

```bash
docker pull <image>
docker images
docker image ls
docker run [options] <image> [command]
docker ps
docker ps -a
docker exec <container> <command>
docker inspect <image_or_container>
docker stop <container>
docker restart <container>
docker rm <container>
docker rmi <image>
docker system df
docker system prune
```

Important `docker run` options:

```bash
--detach
--name <container_name>
-it
--rm
-v /host/path:/container/path
-w /working/directory
-u UID:GID
-p host_port:container_port
```

---

# 20. Building your own Docker image

You build an image from a Dockerfile.

Example Dockerfile:

```Dockerfile
FROM ubuntu:18.04
LABEL org.opencontainers.image.authors="trainingandconferences@vib.be"
WORKDIR /data
RUN apt update && apt -y upgrade
RUN apt install -y wget
ENTRYPOINT ["wget"]
```

Build the image:

```bash
docker build . --tag wget-example:1.0
```

The dot (`.`) indicates the build context: the local folder sent to Docker during the build. Avoid using a very large or cluttered folder as build context.

Dockerfiles should be clear, version-controlled and designed to rebuild reliably. This is the central message of the Ten Simple Rules for writing Dockerfiles for reproducible data science [Nüst et al., 2020](https://doi.org/10.1371/journal.pcbi.1008316).

## Activity 7: Build a small image

1. Create a new folder.
2. Add a file named `Dockerfile`.
3. Add a base image and one installed package.
4. Build the image.
5. Run the image.

Example:

```bash
mkdir docker-build-test
cd docker-build-test
nano Dockerfile
docker build . --tag mytestimage:1.0
docker run --rm mytestimage:1.0
```

---

# 21. Docker image layers and build cache

Each Dockerfile instruction creates a layer. Docker reuses unchanged layers from the build cache.

Build normally:

```bash
docker build -t myimage:1.0 .
```

Build without using the cache:

```bash
docker build --no-cache -t myimage:1.0 .
```

Inspect image history:

```bash
docker history <image_id>
```

Understanding layers helps you write Dockerfiles that build efficiently and reproducibly [Nüst et al., 2020](https://doi.org/10.1371/journal.pcbi.1008316).

---

# 22. Dockerfile best practices

Good Dockerfiles should:

- start from an appropriate base image;
- use explicit versions;
- avoid relying on `latest` tags;
- install only what is needed;
- reduce image size where possible;
- keep data outside the image;
- include labels and metadata;
- document how to run the image;
- be stored in version control;
- respect software licences.

These practices improve transparency, reuse and long-term reproducibility [Nüst et al., 2020](https://doi.org/10.1371/journal.pcbi.1008316), [Grüning et al., 2018](https://doi.org/10.1016/j.cels.2018.03.014).

---

# 23. One tool per image or multiple tools per image?

There is no universal answer. The choice depends on the workflow.

A one-tool image is easier to reuse and maintain. A multi-tool image can be useful for a tightly coupled workflow or training environment. For bioinformatics, a common strategy is to use Conda, Bioconda or BioContainers to create versioned and shareable environments [da Veiga Leprevost et al., 2017](https://doi.org/10.1093/bioinformatics/btx192).

Questions to consider:

- Is the image for one command-line tool or a complete workflow?
- How often do the tools change?
- Can the image be rebuilt from a recipe?
- Is the image small enough to distribute easily?
- Are all software licences compatible with redistribution?

---

# 24. Introduction to Apptainer

Docker is widely used for building and distributing containers, but many HPC systems restrict Docker because Docker usually relies on a privileged daemon. Shared HPC systems must protect users from each other and from privilege escalation risks.

Apptainer, formerly developed from Singularity, was designed for scientific computing and HPC use cases. It allows users to run containers without a Docker-style daemon and is widely used to move scientific software environments between systems [Kurtzer et al., 2017](https://doi.org/10.1371/journal.pone.0177459).

In Apptainer, the important components are:

- **definition file**: the recipe used to build an image;
- **SIF image**: a static image file;
- **container**: the running image;
- **bind mount**: a host folder made available inside the container.

The fact that an Apptainer image is commonly a single `.sif` file makes it convenient to copy, archive and use on HPC systems.

---

# 25. Docker versus Apptainer

Docker strengths:

- large ecosystem;
- excellent developer tooling;
- many public images;
- common in software engineering and cloud deployment.

Apptainer strengths:

- no Docker daemon required;
- can run as a normal user;
- suitable for shared HPC systems;
- images are portable files;
- good match for batch scheduling environments.

Apptainer is not simply a Docker replacement. A common workflow is to build or select images using Docker-compatible registries and then run them with Apptainer on HPC infrastructure [Kurtzer et al., 2017](https://doi.org/10.1371/journal.pone.0177459).

---

# 26. Preparing Apptainer on HPC

Apptainer uses a cache when pulling or building images. On HPC systems, the default cache in the home directory may be too small or not appropriate. It is common to move the cache and temporary directory to scratch storage.

Example:

```bash
export APPTAINER_CACHEDIR=$VSC_SCRATCH/apptainer_cache
export APPTAINER_TMPDIR=$VSC_SCRATCH/apptainer_tmp
mkdir -p $APPTAINER_CACHEDIR
mkdir -p $APPTAINER_TMPDIR
```

Check the version:

```bash
apptainer --version
```

This setup supports large image downloads and builds in HPC contexts.

---

# 27. Pulling Apptainer images

Pull from Singularity Hub:

```bash
apptainer pull hello-world.sif shub://vsoch/hello-world
```

Pull from Docker Hub:

```bash
apptainer pull python_3.9.6.sif docker://python:3.9.6-slim-buster
```

Pull from a URL, such as Galaxy Depot:

```bash
apptainer pull --name fastqc-0.11.9--0.sif \
  https://depot.galaxyproject.org/singularity/fastqc:0.11.9--0
```

Because Apptainer can consume Docker images, it connects the Docker image ecosystem to HPC-friendly execution [Kurtzer et al., 2017](https://doi.org/10.1371/journal.pone.0177459).

## Activity 8: Pull Apptainer images

1. Pull a Python image from Docker Hub.
2. Pull a FastQC image from Galaxy Depot.
3. Compare their behaviour when using `apptainer run`.
4. Inspect their runscript.

---

# 28. Inspecting Apptainer images

Inspect metadata:

```bash
apptainer inspect image.sif
```

Inspect the default runscript:

```bash
apptainer inspect --runscript image.sif
```

The runscript defines what happens when you call:

```bash
apptainer run image.sif
```

Inspection is important because not all images behave the same way. A Python image may start Python, whereas a FastQC image may show tool-specific behaviour.

---

# 29. Running Apptainer containers

Apptainer provides three common execution modes.

## Shell

Open an interactive shell:

```bash
apptainer shell image.sif
```

Leave the shell:

```bash
exit
```

## Run

Execute the image runscript:

```bash
apptainer run image.sif
```

## Exec

Execute a specific command inside the image:

```bash
apptainer exec image.sif fastqc -h
```

These modes support both interactive exploration and batch-oriented scientific computing [Kurtzer et al., 2017](https://doi.org/10.1371/journal.pone.0177459).

---

# 30. Files, users and permissions in Apptainer

Apptainer handles users differently from Docker. In many cases, the user inside the container corresponds to the host user rather than root. This behaviour is one reason Apptainer is attractive on shared HPC systems [Kurtzer et al., 2017](https://doi.org/10.1371/journal.pone.0177459).

Inside an Apptainer shell, try:

```bash
whoami
id
```

Then inspect files in mounted directories. In most teaching scenarios, this leads to fewer permission surprises than Docker, especially when writing output on shared filesystems.

---

# 31. Binding folders with Apptainer

Apptainer can bind host folders into the container.

Bind a folder to the same path:

```bash
apptainer shell -B /path/on/host image.sif
```

Bind a folder to a different path:

```bash
apptainer shell -B /path/on/host:/path/in/container image.sif
```

Example:

```bash
apptainer shell \
  -B /data/gent/courses/2025/vibrepdata_EXT003/shared:/shared-data \
  python_3.9.6.sif
```

Inside the shell:

```bash
ls /shared-data
```

## Activity 9: Binding folders

1. Bind a shared data directory to the same path inside the container.
2. Bind the same directory to `/shared-data`.
3. Compare where the files appear.
4. Try to create a file in the mounted directory.

---

# 32. Running Apptainer jobs in the background

Apptainer commands can be run in the background like other Linux commands.

Example:

```bash
apptainer exec fastqc-0.11.9--0.sif fastqc -h > output.log 2>&1 &
```

On HPC systems, however, you should usually submit longer jobs to the scheduler instead of running them directly on a login node.

---

# 33. Pulling or building images on HPC with Slurm

Pulling or building images may take time and can require significant temporary storage. On Slurm-based HPC systems, this should often be done as a batch job.

Example Slurm script:

```bash
#!/usr/bin/env -S bash -l
#SBATCH --nodes=1
#SBATCH --tasks-per-node=1
#SBATCH --cpus-per-task=4
#SBATCH --time=2:00:00
#SBATCH --mem=16G

export APPTAINER_TMPDIR=$VSC_SCRATCH_NODE/$USER/apptainer_tmp
export APPTAINER_CACHEDIR=$VSC_SCRATCH/apptainer_cache
mkdir -p $APPTAINER_TMPDIR
mkdir -p $APPTAINER_CACHEDIR

apptainer pull python_3.9.6.sif docker://python:3.9.6-slim-buster
```

Submit:

```bash
sbatch submission_script.sh
```

This approach aligns container workflows with HPC scheduling practices.

---

# 34. Building Apptainer images from definition files

An Apptainer definition file describes how to build an image.

Example:

```text
Bootstrap: docker
From: ubuntu:20.04

%post
    apt-get update
    apt-get install -y python3

%runscript
    python3 --version
```

Build:

```bash
apptainer build my_python.sif my_python.def
```

Definition files play a similar role to Dockerfiles: they document the build process and support reproducibility [Kurtzer et al., 2017](https://doi.org/10.1371/journal.pone.0177459).

---

# 35. Apptainer recipe sections

Common sections include:

## Header

```text
Bootstrap: docker
From: continuumio/miniconda3
```

This defines the base image or source.

## `%files`

```text
%files
    environment.yml /environment.yml
```

This copies files from the host into the image during the build.

## `%post`

```text
%post
    apt-get update
    apt-get install -y python3
```

This section installs software and configures the image.

## `%environment`

```text
%environment
    export LC_ALL=C
```

This defines environment variables available at runtime.

## `%runscript`

```text
%runscript
    echo "This is the default action of the container"
```

This defines the default behaviour for `apptainer run`.

## `%test`

```text
%test
    python3 --version
```

This defines a test that can be run after building.

## `%help`

```text
%help
    This container provides Python 3.
```

This provides help text.

## `%labels`

```text
%labels
    Maintainer VIB Training and Conferences
    Version 1.0
```

Labels provide metadata, which improves transparency and reuse.

---

# 36. Modifying Apptainer images with sandboxes

Apptainer images are usually read-only SIF files. For development, you can create a sandbox directory.

Create a sandbox:

```bash
apptainer build --fakeroot ./sandbox original.sif
```

Open a writable shell:

```bash
apptainer shell --writable --fakeroot ./sandbox
```

Modify the environment:

```bash
apt update
apt install less
exit
```

Build a new image:

```bash
apptainer build --fakeroot new.sif ./sandbox
```

Sandbox modification is useful for experimentation and debugging, but it is not the preferred reproducible workflow. For production, translate changes back into a definition file.

---

# 37. Apptainer and GPUs

Apptainer can expose host GPU drivers and libraries to containers. For NVIDIA GPUs, use:

```bash
apptainer exec --nv gpu_image.sif /bin/bash
```

For AMD GPUs, use:

```bash
apptainer exec --rocm gpu_image.sif /bin/bash
```

GPU-enabled containers are common in machine learning and high-performance scientific computing, but they require compatibility between host drivers and container software.

---

# 38. Reproducible scientific workflows with containers

Containers become especially powerful when combined with workflow systems. Nextflow supports portable execution across local machines, clusters and clouds and can use containers for individual workflow steps [Di Tommaso et al., 2017](https://doi.org/10.1038/nbt.3820). Snakemake similarly supports scalable and reproducible workflow execution in bioinformatics [Köster and Rahmann, 2012](https://doi.org/10.1093/bioinformatics/bts480).

In life sciences, BioContainers provides ready-made containers for many bioinformatics tools, reducing the burden of packaging software individually [da Veiga Leprevost et al., 2017](https://doi.org/10.1093/bioinformatics/btx192). Combined with good workflow practices, containers help make computational analyses more transparent, portable and easier to teach [Grüning et al., 2018](https://doi.org/10.1016/j.cels.2018.03.014).

---

# 39. Final course summary

Docker and Apptainer address related but distinct needs.

Docker is especially useful for:

- building images;
- local development;
- publishing software;
- web applications;
- cloud and DevOps workflows.

Apptainer is especially useful for:

- HPC execution;
- running as an ordinary user;
- single-file container images;
- preserving scientific software environments;
- batch-scheduled analysis workflows.

The typical research workflow is often:

```text
Write or select a recipe
        ↓
Build or obtain an image
        ↓
Run the image locally or on HPC
        ↓
Mount input and output data
        ↓
Document software versions and commands
        ↓
Share recipe, workflow and container metadata
```

Containers do not replace good scientific practice, documentation or workflow design. They are one component of a reproducible research strategy. Used well, they make computational training smoother, analysis environments more portable and research outputs easier to rerun.

---

# References

Boettiger C. (2015). *An introduction to Docker for reproducible research.* ACM SIGOPS Operating Systems Review. [https://doi.org/10.1145/2723872.2723882](https://doi.org/10.1145/2723872.2723882)

Combe T, Martin A, Di Pietro R. (2016). *To Docker or Not to Docker: A Security Perspective.* IEEE Cloud Computing. [https://doi.org/10.1109/MCC.2016.14](https://doi.org/10.1109/MCC.2016.14)

da Veiga Leprevost F, Grüning B, Alves Aflitos S, et al. (2017). *BioContainers: an open-source and community-driven framework for software standardization.* Bioinformatics. [https://doi.org/10.1093/bioinformatics/btx192](https://doi.org/10.1093/bioinformatics/btx192)

Di Tommaso P, Chatzou M, Floden EW, Barja PP, Palumbo E, Notredame C. (2017). *Nextflow enables reproducible computational workflows.* Nature Biotechnology. [https://doi.org/10.1038/nbt.3820](https://doi.org/10.1038/nbt.3820)

Felter W, Ferreira A, Rajamony R, Rubio J. (2015). *An updated performance comparison of virtual machines and Linux containers.* IEEE ISPASS. [https://doi.org/10.1109/ISPASS.2015.7095802](https://doi.org/10.1109/ISPASS.2015.7095802)

Grüning B, Chilton J, Köster J, et al. (2018). *Practical Computational Reproducibility in the Life Sciences.* Cell Systems. [https://doi.org/10.1016/j.cels.2018.03.014](https://doi.org/10.1016/j.cels.2018.03.014)

Köster J, Rahmann S. (2012). *Snakemake: a scalable bioinformatics workflow engine.* Bioinformatics. [https://doi.org/10.1093/bioinformatics/bts480](https://doi.org/10.1093/bioinformatics/bts480)

Kurtzer GM, Sochat V, Bauer MW. (2017). *Singularity: Scientific containers for mobility of compute.* PLOS ONE. [https://doi.org/10.1371/journal.pone.0177459](https://doi.org/10.1371/journal.pone.0177459)

Merkel D. (2014). *Docker: Lightweight Linux Containers for Consistent Development and Deployment.* Linux Journal. [https://doi.org/10.5555/2600239.2600241](https://doi.org/10.5555/2600239.2600241)

Nüst D, Sochat V, Marwick B, Eglen SJ, Head T, Hirst T, Evans BD. (2020). *Ten simple rules for writing Dockerfiles for reproducible data science.* PLOS Computational Biology. [https://doi.org/10.1371/journal.pcbi.1008316](https://doi.org/10.1371/journal.pcbi.1008316)

Sandve GK, Nekrutenko A, Taylor J, Hovig E. (2013). *Ten Simple Rules for Reproducible Computational Research.* PLOS Computational Biology. [https://doi.org/10.1371/journal.pcbi.1003285](https://doi.org/10.1371/journal.pcbi.1003285)
