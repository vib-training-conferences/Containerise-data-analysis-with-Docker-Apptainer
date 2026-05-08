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
apptainer build --fakeroot /tmp/$USER/tensorflow-23.06-tf2-py3.sif \
docker://nvcr.io/nvidia/tensorflow:23.06-tf2-py3

mv  /tmp/$USER/tensorflow-23.06-tf2-py3.sif $VSC_SCRATCH/apptainer/

date
echo End Job
