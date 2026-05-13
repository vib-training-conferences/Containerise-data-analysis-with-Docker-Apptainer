# Solution exercise 3


Who is the default user within the container?  
 - Type `whoami`. This will give you `root`. 

Run the `quay.io/biocontainers/fastqc:0.11.9--0` container interactively and mount the local `data/` directory. Create a temporary file `file1.txt` in the `scratch/` directory of the container. Quit the interactive session. On your host, check the file permissions.
 - Run the container interactively: `docker run --rm -it -v $(pwd)/data/:/scratch quay.io/biocontainers/fastqc:0.11.9--0 /bin/bash`
 - Type `touch file1.txt`.   
 - On Mac OS, this will give you on the <your user name> and group staff.   
 - On Linux, this will give you a file with root:root permissions.


On the host, create a temporary file `file2.txt` in the `data/` directory. Run the `fastqc` container interactively and inspect the file permissions of this file in the container.  
 - Type `touch file2.txt` on the host in the `data/` directory.   
 - Run the container interactively: `docker run --rm -it -v $(pwd)/data/:/scratch quay.io/biocontainers/fastqc:0.11.9--0 /bin/bash`
 - In the container, this will give you on e.g. 1004:1004.  
The file will appear to have user ID (UID) and group ID (GID) numbers from the user that created this in the host. If these UID and GID do exist in the container, they may have a name instead.


On the host, find out which UID and GID you have. Tip: you can find your UID and GID with: `id -u` and `id -g`. 
 - Running `id -u` will give you the effective user number, and `id -g` of the effective group number. 

Execute a docker container by using the `-u` parameter and and in the meantime creating a temporary file `file3.txt` with `touch`. In addition, mount your current directory to `/data` within the Docker container `quay.io/biocontainers/fastqc:0.11.9--0`. Check the file permissions of this file in the container.   
 - By using this command line, enter your UID and GID 
`docker run --rm -v $(pwd)/data/:/scratch -u <your UID>:<your GID> quay.io/biocontainers/fastqc:0.11.9--0 touch /scratch/file3.txt`
 - Especially, on your Linux host, verify the file permissions of the file `file3.txt`.
