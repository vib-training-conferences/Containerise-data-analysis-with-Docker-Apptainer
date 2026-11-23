#!/usr/bin/env -S bash -l
#SBATCH -A 2026_400
#SBATCH --nodes=1 --tasks-per-node=1 --cpus-per-task=4
#SBATCH --time=2:00:00
#SBATCH --mem 16G
#SBATCH --partition cluster/dodrio/cpu_milan_rhel9
#SBATCH --output=ID_%j_%x.out
#SBATCH --error=ID_%j_%x.err

# go to the (current) working directory (optional, if this is the
# directory where you submitted the job)
cd /tmp
mkdir /tmp/$USER

COURSE_REPO_DIR=/dodrio/scratch/projects/2026_400/20261123-Containerize-data-analysis/alexb/Containerise-data-analysis-with-Docker-Apptainer

#cp $COURSE_REPO_DIR/apptainer/environment.yml /tmp/environment.yml

echo Start Job
date

APPTAINER_CACHEDIR=/tmp/$USER \
APPTAINER_TMPDIR=/tmp/$USER \
apptainer build --fakeroot /tmp/$USER/geopandas.sif $COURSE_REPO_DIR/apptainer/apptainer-recipe.def

mv /tmp/$USER/geopandas.sif $COURSE_REPO_DIR/geopandas-v1.sif
