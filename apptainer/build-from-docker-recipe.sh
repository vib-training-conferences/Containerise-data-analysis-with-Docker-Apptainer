#!/bin/bash
#SBATCH -A 2026_400
#SBATCH --job-name=build-apptainer
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --time=1:00:00
#SBATCH -partition cluster/dodrio/cpu_milan_rhel9
#SBATCH --output=ID_%j_%x.out
#SBATCH --error=ID_%j_%x.err

# eventually load other modules
#module purge
#module load Package1 Package2 Package3

# go to the (current) working directory (optional, if this is the
# directory where you submitted the job)
cd /tmp
mkdir /tmp/$USER

COURSE_REPO_DIR=/dodrio/scratch/projects/2026_400/20261123-Containerize-data-analysis/alexb/Containerise-data-analysis-with-Docker-Apptainer/

#cp $VSC_SCRATCH/containers-workshop/apptainer/environment.yml /tmp/environment.yml

echo Start Job
date

APPTAINER_CACHEDIR=/tmp/$USER/apptainer/cache \
APPTAINER_TMPDIR=/tmp/$USER \
apptainer build --fakeroot /tmp/$USER/mutatex.sif $COURSE_REPO_DIR/apptainer/mutatex.def

mv /tmp/$USER/mutatex.sif $COURSE_REPO_DIR/mutatex-v1.sif

date
echo End Job
