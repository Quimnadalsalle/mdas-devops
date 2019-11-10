########## BUILDER ##########
#La imagen de golang viene de debian. Podemos tener muchos stages
FROM golang AS builder
#copio desde votingapp hasta la imagen

RUN go get github.com/gorilla/websocket && \
    go get github.com/labstack/echo

COPY . .

RUN go build -o ./build/votingapp && \
    cp -r ui /build

######### RUNTIME #############
FROM ubuntu:18.04

#RUN apt-get update && apt-get install golang -y && rm -rf /var/lib/apt/lists/*
#Me situo en la carpeta app y le hago un copy de build
WORKDIR /app
COPY --from=builder build .

ENTRYPOINT [ "./votingapp" ]




