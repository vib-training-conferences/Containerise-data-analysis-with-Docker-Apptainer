## Solution (based on iamge from registry directly)
docker run --rm -v ./:/home/jovyan/ -w /home/jovyan jupyter/scipy-notebook:lab-4.0.6 python codereppy_min_batch.py

## Solution based on image mentioned in Dockerfile.play
docker run --rm -v ./:/home/jovyan/ -w /home/jovyan jupyter/scipy-notebook:python-3.11.5 python codereppy_min_batch.py

