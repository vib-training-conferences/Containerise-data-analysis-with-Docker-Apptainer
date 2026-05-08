#!/bin/bash
#SBATCH --job-name=build-apptainer
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --time=1:00:00
#SBATCH --output=build1.stdout
#SBATCH --error=build1.stderr

# eventually load other modules
#module purge
#module load Package1 Package2 Package3

# go to the (current) working directory (optional, if this is the
# directory where you submitted the job)

#cp $VSC_SCRATCH/containers-workshop/apptainer/stab-ddg-environment.yml /tmp/stab-ddg-environment.yml

echo Start Job
date

APPTAINER_CACHEDIR=/tmp/ \
APPTAINER_TMPDIR=/tmp/ \
apptainer build --fakeroot $VSC_SCRATCH/stab-ddg.sif $VSC_SCRATCH/containers-workshop/apptainer/stab-ddg.def

#mv /tmp/stab-ddg.sif $VSC_SCRATCH/

date
echo End Job
