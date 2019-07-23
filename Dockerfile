FROM tensorflow/tensorflow:1.14.0-gpu-py3
WORKDIR /usr/src/app

RUN apt-get update -y && apt install -y vim tmux
COPY . .
CMD ["bash", "run_skt_test.sh"]

