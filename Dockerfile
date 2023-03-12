FROM ubuntu:latest
ENV DEBIAN_FRONTEND="noninteractive" TZ="Europe/Paris"

RUN apt update -y && \
    apt install -y wget lsb-core mono-complete unzip xvfb x11vnc fluxbox

RUN dpkg --add-architecture i386 && \
    mkdir -pm755 /etc/apt/keyrings && \
    wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key && \
    wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/ubuntu/dists/$(lsb_release -sc)/winehq-$(lsb_release -sc).sources && \
    apt update -y && \
    apt install -y --install-recommends winehq-stable

WORKDIR /root

RUN mkdir -p /root/.cache/wine/ && \
    wget -O /root/.cache/wine/wine-mono-7.4.0-x86.msi https://dl.winehq.org/wine/wine-mono/7.4.0/wine-mono-7.4.0-x86.msi

COPY *.zip /root/
RUN unzip /root/*.zip

ENV DISPLAY :1
CMD Xvfb :1 -screen 0 600x450x16 & fluxbox & x11vnc -forever & wine /root/on-the-run-classic.exe
