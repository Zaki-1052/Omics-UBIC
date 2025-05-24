# Use CUDA-enabled base image for GPU support
FROM ghcr.io/ucsd-ets/rstudio-notebook:2025.2-stable

LABEL maintainer="Zakir Alibhai <zalibhai@ucsd.edu>"

# Switch to root for system package installation
USER root

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    wget \
    curl \
    git \
    htop \
    zlib1g-dev \
    libbz2-dev \
    liblzma-dev \
    libncurses5-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install Mamba for faster conda installations
RUN conda install -n base -c conda-forge mamba

# Install bioinformatics tools using mamba
RUN mamba install -y -c bioconda -c conda-forge \
    vg \
    bwa \
    samtools \
    bcftools \
    graphaligner \
    pysam \
    numpy \
    pandas \
    scipy \
    scikit-learn \
    matplotlib \
    seaborn \
    plotly \
    scanpy \
    anndata \
    jupyter \
    ipykernel \
    && mamba clean -afy

# Install Python packages
RUN pip install --no-cache-dir \
    tensorqtl \
    networkx \
    statannotations \
    seaborn-image \
    adjustText

# Install R and Seurat
RUN mamba install -y -c conda-forge \
    r-base \
    r-seurat \
    r-devtools \
    r-tidyverse \
    && mamba clean -afy

# Create working directory
WORKDIR /workspace

# Switch back to notebook user
USER ${NB_UID}

# Add project paths to PYTHONPATH
ENV PYTHONPATH="${PYTHONPATH}:/workspace/scripts"