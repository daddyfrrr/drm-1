FROM python:3.10-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
        git \
        curl \
        wget \
        python3-pip \
        bash \
        neofetch \
        ffmpeg \
        software-properties-common && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .

RUN pip3 install --no-cache-dir wheel && \
    pip3 install --no-cache-dir -U -r requirements.txt

COPY . .

EXPOSE 5000

CMD flask run -h 0.0.0.0 -p 5000 & python3 main.py
