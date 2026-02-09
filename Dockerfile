FROM pytorch/pytorch:1.9.0-cuda11.1-cudnn8-devel

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    nano \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y --no-install-recommends \
    libgl1-mesa-glx \
    libglib2.0-dev \
    psmisc \
    && rm -rf /var/lib/apt/lists/*

RUN conda install -y faiss-gpu scikit-learn pandas flake8 yapf isort yacs gdown future -c conda-forge

RUN pip install --no-cache-dir opencv-python tb-nightly
