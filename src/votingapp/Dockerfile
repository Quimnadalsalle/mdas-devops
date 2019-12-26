<<<<<<< HEAD
<<<<<<< HEAD
########## BUILDER ##########
#La imagen de golang viene de debian. Podemos tener muchos stages
FROM golang AS builder
#copio desde votingapp hasta la imagen
=======
######### BUILD #############

FROM alpine:latest AS builder
 
RUN apk update && \
    apk add bash && \
    apk add --no-cache git make musl-dev go
>>>>>>> pipeline_docker_alpine_v2

RUN go get github.com/gorilla/websocket && \
    go get github.com/go-redis/redis && \
    go get github.com/labstack/echo
  

COPY . .

RUN go build -o ./build/votingapp && \
    cp -r ui /build

######### RUNTIME #############
FROM alpine:latest

#Me situo en la carpeta app y le hago un copy de build
WORKDIR /app
COPY --from=builder build .

ENTRYPOINT [ "./votingapp" ]
<<<<<<< HEAD




=======
######## BUILDER #########
FROM golang AS builder

RUN go get github.com/gorilla/websocket && \
    go get github.com/labstack/echo && \
    go get github.com/go-redis/redis

COPY . .

RUN go build -o /build/votingapp && \
    cp -r ui /build


######## RUNTIME #########
FROM ubuntu:18.04

WORKDIR /app
COPY --from=builder /build .

ENTRYPOINT [ "./votingapp" ]
>>>>>>> acb024874f080c03ab3796195a4b94b7d8210770
=======
>>>>>>> pipeline_docker_alpine_v2
