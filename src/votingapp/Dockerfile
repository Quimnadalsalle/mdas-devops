FROM ubuntu:18.04

#RUN apt-get update && apt-get install golang -y && rm -rf /var/lib/apt/lists/*
#Me situo en la carpeta app y le hago un copy de build
WORKDIR /app
COPY build 

ENTRYPOINT [ "./votingapp" ]




