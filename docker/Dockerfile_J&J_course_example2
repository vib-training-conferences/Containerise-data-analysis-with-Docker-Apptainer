FROM ubuntu:18.04

LABEL description = "Minimal image for the J&J course Docker - example 2."
MAINTAINER "Alexander Botzki" alexander.botzki@vib.be

# Use bash as shell
SHELL ["/bin/bash", "-c"]
# Set workdir
WORKDIR /course

# Install necessary tools
RUN apt-get update && \
    apt-get install -y --no-install-recommends bzip2 \
                                               ca-certificates \
                                               curl \
                                               fontconfig \
                                               git \
                                               language-pack-en \
                                               vim \
                                               unzip \
                                               wget \
    && apt-get clean

# Install Miniconda and add to PATH
RUN wget https://repo.continuum.io/miniconda/Miniconda3-4.7.12.1-Linux-x86_64.sh && \
    bash Miniconda3-4.7.12.1-Linux-x86_64.sh -bf -p /usr/miniconda3/ && \
    rm Miniconda3-4.7.12.1-Linux-x86_64.sh && \
    /usr/miniconda3/bin/conda clean -tipsy && \
    ln -s /usr/miniconda3/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /usr/miniconda3/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc

# Add conda to PATH and set locale
ENV PATH="/usr/miniconda3/bin:${PATH}"
ENV LC_ALL en_US.UTF-8
ENV LC_LANG en_US.UTF-8

# copy environment.yml into the image 
COPY environment.yml /
RUN conda env create -f /environment.yml && conda clean -a
ENV PATH=/usr/miniconda3/envs/pipeline-tools-1.0.0/bin/:$PATH
