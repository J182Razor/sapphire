FROM nvidia/cuda:12.4.0-runtime-ubuntu22.04 AS base

ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1

RUN apt-get update && apt-get install -y --no-install-recommends \
    libportaudio2 \
    libsndfile1 \
    portaudio19-dev \
    ffmpeg \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN curl -sS https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -o /tmp/miniconda.sh && \
    bash /tmp/miniconda.sh -b -p /opt/conda && \
    rm /tmp/miniconda.sh

ENV PATH="/opt/conda/bin:$PATH"

RUN conda create -n sapphire python=3.11 -y && \
    conda clean -afy

SHELL ["conda", "run", "-n", "sapphire", "/bin/bash", "-c"]

COPY requirements.txt requirements-minimal.txt ./

RUN pip install --upgrade pip && \
    pip install -r requirements.txt

COPY . .

ENV PYTHONPATH="/app:$PYTHONPATH"

EXPOSE 8073

CMD ["python", "main.py"]
