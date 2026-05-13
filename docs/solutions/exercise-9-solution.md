docker run --rm --platform linux/amd64 -u="$(id -u):$(id -g)" \ 
                           --mount type=bind,source="$(pwd)/data/",target=/scratch/data \
                           --mount type=bind,source="$(pwd)",target=/scratch \
                           -w /scratch irefindex20/r-data-analysis:v1 \ 
                           bash -c "Rscript accidents.R --data ./data"
