# Exercises on building Dockerfiles

### Learning outcomes
After having completed these exercises you will be able to:  
* Use the docker build to build a Docker image on the command line
* Use other Docker recipe file names with the `-f` option
* Understand the options for Docker recipe creation for bioinformatics tools like native installation or conda
* Use the basic statements to create a Dockerfile
* Understand the provenance of parent images of Docker images
* follow good practises for Dockerfile annotation and example build and run statements

This set of exercises aim to get you familiar with how a Docker image can be build. 

### Prerequisite

- Clone the github repository of the course material https://github.com/vibbits/containers-workshop to your home folder

### Exercise 1 part 1

Imagine the following situation. To make a simple data analysis project as reproducible as possible, we propose to create a container environment using Docker which contains the necessary tools and scripts. 
We have two use cases: a) we would like to run the Python scripts in a headless form and b) we think that a Jupyterlab is useful environment to play around with the data analysis.

In order to create a Dockerfile for these use cases, a scrambled Dockerfile has been created and is provided as starting point for this exercise.

Have a look at this Dockerfile and bring the statements in the correct order so that building the Docker image works fine.

### Exercise 1 part 2

Once you have built an image based on the corrected Dockerfile, run the script codereppy_min_batch with the Python version installed in the image.

### Exercise 1A part 1

Imagine the following situation. To make a simple data analysis project as reproducible as possible, we propose to create a container environment using Docker which contains the necessary tools and scripts. 
We have two use cases: a) we would like to run the Python scripts in a headless form.

In order to create a Dockerfile for these use cases, a scrambled Dockerfile has been created and is provided as starting point for this exercise.

Have a look at this Dockerfile `accidents/Dockerfile` and bring the statements in the correct order so that building the Docker image works fine.

### Exercise 1A part 2

Once you have built an image based on the corrected Dockerfile, run the script `accidents.R --data <dataset>` using the dataset in the folder `data` with the Python version installed in the image.

### Exercise 2

We would like to create a simple Docker image which is based on the micromamba docker image. Consult the documentation and the Quick start document at https://micromamba-docker.readthedocs.io/en/latest/quick_start.html to construct a Dockerfile which uses the `environment.yml` file in the main folder of this repository.
Once successfully build, run the fastqc command with the examples fastq.gz files used in the other chapter this morning.

### Exercise 3

We would like to build a simple Docker image which is based on the base image `ray` version 1.10.0 of the `rayproject`. Consult the setup referenced here (https://github.com/anyscale/academy/tree/main/ray-serve/e2e/deploy-cloud-run) to construct a Dockerfile which uses the `requirements.txt` file in the main folder of this repository.
Once successfully build, run the command `python test-query.py`.

## Exploratory exercises (no guarantee that the build process will still work)

### Exercise 3 part 1

We start from a Dockerfile which has been prepared upfront and will add some statements iteratively to create a valid Dockerfile for the tool methplotlib developed at VIB UAntwerp by Wouter De Coster.

1. Please have look at the folder `docker` and open the file `Dockerfile.methplotlib.start`.

1. In this example, we will start from a parent image from `Biocontainer.pro`. Try to find the Dockerfile recipe of this parent image via an internet search.

- What the user which is used in the image when tools are run?
- What mount points (volumes) are present?
- Could you spot a potential weakness of the way the parent image is described in the Dockerfile recipe regarding reproducibility of the container image?

3. Let's go back to the current Dockerfile and try to create Docker recipe for the tool `methplotlib`. Have a look at the github repository of tool [methplotlib](https://bio.tools/methplotlib). Based on the explanation how to install `methplotlib`, formulate a statement for this Dockerfile to install the tool.
3. Try to build the Docker image by adding a version tag to the build name.

- Does the build pass successfully?

5. Formulate an additional statement to address the error message and rebuild the Docker image. 

5. Run the image with your user and group id, mount the local `data` folder to the internal `data`folder using the working directory `/data` on the information in the example folder described in the github repository of methplotlib.

- Which version of methplotlib is the current one?

5. Have a look at the Dockerfile and what additional statements are present for annotation of the Docker image. It is good practise to provide metadata about the image, its maintainer and license for use. Furthermore, it is very handy for developers to have readily available instructions on how to build the container and run a basic command.

### Exercise 3 part 2

As an additional example, we would like to create a Docker image using a conda environment for methplotlib. Again, a skeleton of the Dockerfile is present `Dockerfile.methplotlib.conda`.

1. Add a statement for the installation of the tool to this Dockerfile. Please use the latest version of methplotlib.  
The following commands will be useful:

- conda create --name methplotlib
- conda config --add channels bioconda
- conda install --name methplotlib methplotlib=X.XX.X
- conda config --add channels conda-forge

2. Try to build the Docker image and run `methplotlib -v`.

- With what Docker statement could you add the PATH `PATH=/usr/miniconda3/envs/methplotlib/bin/:$PATH`?

3. Add annotations as well as build instructions for the alternative Docker image based on first example.

### Exercise 3 part 3
Lastly, a file called `Dockerfile` has been provided which contains correct statements but the order is shuffled around which makes the file unusable as it is.
Put the statements in the correct order and build the Docker image with the very simple environment for RNA-seq pre-processing steps.
Please add also a correct example usage to check whether the fastqc tool in the containers runs correcty.

