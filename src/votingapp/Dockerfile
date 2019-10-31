<<<<<<< HEAD
<<<<<<< HEAD
########## BUILDER ##########
<<<<<<< HEAD
#La imagen de golang viene de debian. Podemos tener muchos stages
FROM golang AS builder
#copio desde votingapp hasta la imagen
=======
######## BUILDER #########
FROM golang AS builder
>>>>>>> 47511f6... sesion3

RUN go get github.com/gorilla/websocket && \
    go get github.com/labstack/echo && \
    go get github.com/go-redis/redis

COPY . .

<<<<<<< HEAD
=======
FROM alpine:latest AS builder
 
RUN apk update && \
    apk add bash && \
    apk add --no-cache git make musl-dev go

RUN go get github.com/gorilla/websocket && \
    go get github.com/go-redis/redis && \
    go get github.com/labstack/echo
  

COPY . .
>>>>>>> e46e554... containers up, missing to execute them
RUN go build -o ./build/votingapp && \
    cp -r ui /build

######### RUNTIME #############
FROM ubuntu:18.04

#RUN apt-get update && apt-get install golang -y && rm -rf /var/lib/apt/lists/*
#Me situo en la carpeta app y le hago un copy de build
WORKDIR /app
COPY --from=builder build .

ENTRYPOINT [ "./votingapp" ]




=======
=======
RUN go build -o /build/votingapp && \
    cp -r ui /build


######## RUNTIME #########
>>>>>>> 47511f6... sesion3
FROM ubuntu:18.04

WORKDIR /app
COPY --from=builder /build .

ENTRYPOINT [ "./votingapp" ]
>>>>>>> df088bb... docker pipeline, sesion2
