FROM pytorch/pytorch:1.9.0-cuda11.1-cudnn8-devel

# 设置环境变量避免交互提示
ENV DEBIAN_FRONTEND=noninteractive

# 第一步：只更新apt源，带重试机制
RUN for i in {1..3}; do apt-get update && break || sleep 5; done

# 第二步：分批安装包，先安装最关键的网络工具
RUN apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    && rm -rf /var/lib/apt/lists/*

# 第三步：更新证书
RUN update-ca-certificates

# 第四步：再次更新并安装其他包（先尝试不需要网络复杂的包）
RUN apt-get update && apt-get install -y --no-install-recommends \
    nano \
    psmisc \
    && rm -rf /var/lib/apt/lists/*

# 第五步：安装图形库（这些有时需要额外配置）
RUN apt-get update && apt-get install -y --no-install-recommends \
    libgl1-mesa-glx \
    libglib2.0-dev \
    && rm -rf /var/lib/apt/lists/*

# Conda安装包
RUN conda install -y faiss-gpu scikit-learn pandas flake8 yapf isort yacs gdown future -c conda-forge

# Pip安装包
RUN pip install --no-cache-dir opencv-python tb-nightly
