FROM python:3.7.4
MAINTAINER Baris EKICI <barisekici@icloud.com>

COPY . /app
WORKDIR /app

RUN pip install --upgrade pip
RUN pip install -r /app/requirements.txt



ENTRYPOINT [ "robot" ]
