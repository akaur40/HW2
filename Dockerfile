FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive \
    TZ=UTC

# Install basic tools
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Install Miniconda
ENV CONDA_DIR=/opt/conda
RUN wget -q https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/miniconda.sh \
    && bash /tmp/miniconda.sh -b -p $CONDA_DIR \
    && rm /tmp/miniconda.sh

ENV PATH=$CONDA_DIR/bin:$PATH

# Configure conda channels
RUN conda config --system --remove channels defaults 2>/dev/null || true \
    && conda config --system --prepend channels conda-forge \
    && conda config --system --append channels bioconda \
    && conda config --system --set channel_priority strict

# Copy environment file
COPY environment.yml /tmp/environment.yml

# Create conda environment
RUN sed -i '/^prefix:/d' /tmp/environment.yml \
    && conda env create -y -p /opt/conda/envs/ads8192 -f /tmp/environment.yml \
    && rm /tmp/environment.yml \
    && conda clean -afy

ENV PATH=/opt/conda/envs/ads8192/bin:$PATH \
    R_HOME=/opt/conda/envs/ads8192/lib/R

# Set working directory
WORKDIR /app

# Copy your package
COPY r-package /app

# Install Rapp FIRST (required dependency)
RUN Rscript -e 'options(repos = c(CRAN = "https://cloud.r-project.org")); install.packages("Rapp")'

# Install your package
RUN R CMD INSTALL /app

# Install CLI
RUN Rscript -e 'library(Rapp); Rapp::install_pkg_cli_apps("ADS8192")'

# Add CLI to PATH
ENV PATH=/root/.local/bin:$PATH

# Default command
CMD ["R", "--no-save", "-q"]