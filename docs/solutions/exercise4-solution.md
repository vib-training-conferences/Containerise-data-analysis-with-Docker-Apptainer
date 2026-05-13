# Solution exercise 4

Execute a docker container by using the working directory option `-w` for a directory `/workdir` and create a temporary file `file4.txt` with `touch`. In addition, mount your current directory to `/workdir` within the Docker container `quay.io/biocontainers/fastqc:0.11.9--0`. Check the file location of this file in the container.
 - `docker run --rm -v $(pwd)/data/:/scratch -w /scratch -u 1000:1000 quay.io/biocontainers/fastqc:0.11.9--0 touch file4.txt`



Execute a docker container with your user and group ID running `fastqc` on the file `ecoli_X.fastq.gz`. In addition, mount your current directory to the default working directory within the Docker container `quay.io/biocontainers/fastqc:0.11.9--0`. Verify that the HTML report is created with the correct file permissions.

```     
# Solution (first remove the fastqc results with root permission that we created earlier)
docker run \
    --rm \
    -u "$(id -u):$(id -g)" \
    -w /data \
    -v $(pwd)/data/:/data \
    quay.io/biocontainers/fastqc:0.11.9--0 \
    fastqc ecoli_1.fastq.gz
```
Or instead of `-v`/`--volume`, use `--mount`:
```
--mount type=bind,source=$(pwd)/data/,target=/data \
```

 - Extra: can you analyze all fastq files using a glob-pattern (`ecoli*.fastq.gz`)? What do you need to change to make this work? 
    - You will need to use `/bin/bash -c "fastqc ecoli*.f*.gz"`

Use the command `docker inspect` on the image `quay.io/biocontainers/fastqc:0.11.9--0` and extract the working directory (`WorkingDir`) using `grep`.
 - `docker inspect biocontainers/fastqc:v0.11.9_cv8 | grep 'WorkingDir'`

Go to [Biocontainers.pro](https://biocontainers.pro/) and find the Docker image of `trimmomatic`. In addition, mount your current directory to the default working directory within the Docker container of `trimmomatic`. Verify that the HTML report is created with the correct file permissions.

```
docker run \
    --rm \
    -u="$(id -u):$(id -g)" \
    --mount type=bind,source=$(pwd)/data/,target=/data \
    quay.io/biocontainers/trimmomatic:0.35--6 \
    trimmomatic \
        SE \
        -threads 1 \
        -phred33 \
        data/ecoli_1.fastq.gz \
        data/ecoli_1_trimmed.fastq.gz  \
        ILLUMINACLIP:$ADAPTERS:2:30:10 \
        SLIDINGWINDOW:4:5 \
        LEADING:5 \
        TRAILING:5 \
        MINLEN:25
```
