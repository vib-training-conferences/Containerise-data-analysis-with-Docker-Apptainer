# Exercises on running Docker containers

The first set of exercises are related to running Docker containers. They will give us an in-depth overview of the most important things we need to consider when it comes to running Docker containers. 


### Learning outcomes
After having completed these exercises you will be able to:  
* Use the command line to run a containerized bioinformatics tool on the command line
* Set the default user and group with the `-u` option
* Run a command inside a container non-interactively
* Use `docker inspect`to get more information on an image and container
* Overwrite the default working directory within a container with `-w` 
* Use the option `--mount` to bind mount a host directory to a container

### Container
For this set of exercises we will use a simple Docker container for `fastQC` process, more specifically [quay.io/biocontainers/fastqc](https://quay.io/repository/biocontainers/fastqc?tab=info) (version 0.11.9--0). 
At the end of the exercises, you will run `fastQC` on a fastq-file by using a Docker container.

### Data
The example fastq file(s) are located in the `./data/` folder. If not present, or you want to download them yourself, you can retrieve them with the following commands. We will use them in combination with the Docker containers to mimic a simple, though relevant bioinformatics data analysis process. 

In the `data` folder, there is a download script which you can use on POSIX shell (Mac OS, Linux) with `bash downl-data.sh` or `./downl-data.sh` when this shell script is executable.

Alternatively, we could use other files stored online as a zipped tar file.

```sh
wget https://introduction-containers.s3.eu-central-1.amazonaws.com/ecoli_reads.tar.gz
tar -xzvf ecoli_reads.tar.gz
```

Make sure they are located in the `data/` folder. 

## 1. Pull and run the Docker container

Let's first explore how we can retrieve a Docker image from its repository and use it locally on our computer (or VM in this case). As mentioned above, we will use [quay.io/biocontainers/fastqc](https://quay.io/repository/biocontainers/fastqc?tab=info) as our Docker container and more specifically the version `0.11.9--0`. 

### Exercise 1
- Use a `docker` command that will retrieve the image from the repository and store it locally. 
- Run the following command in the container: `fastqc -h`. Add some additional features: remove it after it has run, and give the container a name. (Why is it useful to give containers an additional name?)
- Run the container interactively and start it with `bash`. 

--- 


To have an overview of all the images locally available, use:
```
docker images
```
To have an overview of all running containers:
```
docker ps
```
We can stop and subsequently remove a running container with 
```
docker stop <container-id>
docker rm <container-id>
```


## 2. Bind mounting a local directory

Now we have the data and now how to interact with the Docker image and container, let's explore how we can process the data with the container. 

Docker containers are fully isolated. It is necessary to mount volumes in order to handle input/output files. By default, Docker containers cannot access data on the host system. This means that:
- we can’t use host data in the containers
- all data stored in the container will be lost when the container exits

This can be solved in two ways as we have seen from the theory. 



### Exercise 2
- Run a docker container and approach it interactively. In addition, mount the local `data/` folder to a new folder in the container `/data` within the Docker container `quay.io/biocontainers/fastqc:0.11.9--0`. Additional parameters: remove the container after it has run.   

- Do a quality control on the WT samples by using the following command: `fastqc /data/WT_lib1_R1.fq.gz` or `fastqc /data/ecoli_1.fastq.gz`. For this you can use the command here above and change the interactive part for the actual command. Why do we need to add `/data/` in the `fastqc` command. 

--- 

Note: Don't mount a directory that contains a lot of files or subdirectories (like `~`)


## 3. Managing file and folder permissions 
The following exercises aim to give an idea of how folders and files are managed on your computer locally as opposed to our Docker containers. 

### Exercise 3

- Who is the default user within the container?  

- Run the `quay.io/biocontainers/fastqc:0.11.9--0` container interactively and mount the local `data/` directory. Create a temporary file `file1.txt` in the `scratch/` directory of the container. Quit the interactive session. On your host, check the file permissions.

- On the host, create a temporary file `file2.txt` in the `data/` directory. Run the `fastqc` container interactively and inspect the file permissions of this file in the container.  Check the file permissions of this file in the container (`scratch/` directory).  

- On the host, find out which UID and GID you have. Tip: you can find your UID and GID with: `id -u` and `id -g`. 

- Execute a docker container by using the `-u` parameter and and in the meantime creating a temporary file `file3.txt` with `touch`. In addition, mount your current directory to `/data` within the Docker container `quay.io/biocontainers/fastqc:0.11.9--0`. Check the file permissions of this file in the container.  

---

After these exercises it should be clear that docker containers will output files at `root`-level by default, however that we can overcome this behaviour by using the user ID and group ID levels on run-time. To generalize this command over different infrastructures (with possible different settings) we can provide it the following parameter `--user $(id -u):($id -g)`. 

## 4. Using working directories 

The *working directory* sets the location for running instructions (installations, commands, file copying, etc.) defined in the `Dockerfile`. The working directory is described in the `Dockerfile` with:
```
WORKDIR /path/to/workdir
```
As an example, have a look at the Dockerfile of our `fastqc` container [here](https://github.com/BioContainers/containers/blob/master/fastqc/0.11.9/Dockerfile). 

### Exercise 4

- Execute a docker container by using the working directory option `-w` for a directory `scratch/` and creating a temporary file `file4.txt` with `touch`. In addition, mount your current directory to `scratch/` working directory within the Docker container `quay.io/biocontainers/fastqc:0.11.9--0`. Check the file location of this file on the host.



- Execute a docker container with your user and group ID running `fastqc` on the file `WTXXX.fq.gz`. In addition, mount your current directory to the default working directory within the Docker container `quay.io/biocontainers/fastqc:0.11.9--0`. Verify that the HTML report is created with the correct file permissions.
    - Extra: can you analyze all fastq files using a glob-pattern (`WT*.fq.gz`)? What do you need to change to make this work? 

- Use the command `docker inspect` on the image `biocontainers/fastqc:v0.11.9_cv8` and extract the working directory (`WorkingDir`) using `grep`.


- Go to [Biocontainers.pro](https://biocontainers.pro/) and find the Docker image of `trimmomatic`. In addition, mount your current directory to the default working directory within the Docker container of `trimmomatic`. Verify that the HTML report is created with the correct file permissions.

For this you can use the following set of parameters:
```
    SE \
    -threads 1 \
    -phred33 \
    input.fastq \
    output.fastq \
    ILLUMINACLIP:$ADAPTERS:2:30:10 \
    SLIDINGWINDOW:4:5 \
    LEADING:5 \
    TRAILING:5 \
    MINLEN:25

```


