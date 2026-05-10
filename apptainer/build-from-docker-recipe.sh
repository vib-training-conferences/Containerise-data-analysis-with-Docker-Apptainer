#!/bin/bash
#SBATCH --job-name=build-apptainer
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --time=1:00:00
#SBATCH --output=build-recipe.stdout
#SBATCH --error=build-recipe.stderr

# eventually load other modules
#module purge
#module load Package1 Package2 Package3

# go to the (current) working directory (optional, if this is the
# directory where you submitted the job)
cd /tmp
mkdir /tmp/$USER

COURSE_REPO_DIR=/data/gent/courses/2025/vibrepdata_EXT003/input/Containerise-data-analysis-with-Docker-Apptainer

#cp $VSC_SCRATCH/containers-workshop/apptainer/environment.yml /tmp/environment.yml

echo Start Job
date

APPTAINER_CACHEDIR=/tmp/$USER \
APPTAINER_TMPDIR=/tmp/$USER \
apptainer build --fakeroot /tmp/$USER/mutatex.sif $COURSE_REPO_DIR/apptainer/mutatex.def

mv /tmp/$USER/mutatex.sif $VSC_SCRATCH/mutatex-v1.sif

date
echo End Job
