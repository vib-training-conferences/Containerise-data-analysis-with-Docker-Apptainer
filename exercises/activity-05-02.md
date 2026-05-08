# Activity 5.2

Imagine the following situation. To make a simple data analysis project as reproducible as possible, we propose to create an environment using Docker which contains the necessary tools and scripts. 

We have two use cases: a) we would like to run the Python scripts in a headless form and b) we think that a Jupyterlab is useful environment to play around with the data analysis.

Let's focus on case a) first. As input, We have a scrambled Dockerfile called Dockerfile.play_jupyter in the `exercises` folder as starting point for this activity.

Have a look at this Dockerfile and bring the statements in the correct order so that building the Docker image works fine.

Question: How could you test that the succesfull build of the image has created a functional image? 
