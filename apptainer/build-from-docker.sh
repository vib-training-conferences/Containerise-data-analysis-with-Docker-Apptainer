#!/bin/bash
#SBATCH --job-name=build-apptainer
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --time=1:00:00
#SBATCH --mem=16GB
#SBATCH --output=pull-from-docker.stdout
#SBATCH --error=pull-from-docker.stderr

# eventually load other modules
#module purge
#module load Package1 Package2 Package3

# go to the (current) working directory (optional, if this is the
# directory where you submitted the job)
cd /tmp
mkdir /tmp/$USER

echo Start Job
date

APPTAINER_CACHEDIR=/tmp/ \
APPTAINER_TMPDIR=/tmp/ \

apptainer build --fakeroot /tmp/$USER/fastqc-0.11.9.sif \
docker://biocontainers/fastqc:v0.11.9_cv8

mv /tmp/$USER/fastqc-0.11.9.sif $VSC_SCRATCH

date
echo End Job
