FROM ubuntu:24.04

RUN apt update \
    && apt install --yes --no-install-recommends python3 python3-pip \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .
COPY app.py .

RUN pip3 install -r requirements.txt --root /
ENV GREETING="Hello Docker"
ENV PORT=8080
EXPOSE $PORT
CMD ["python3", "app.py"]
