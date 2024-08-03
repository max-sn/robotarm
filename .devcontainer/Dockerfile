FROM texlive/texlive:latest-full

RUN apt-get update && apt-get install -y zip openssh-server

RUN useradd --create-home --shell /bin/bash max

USER max