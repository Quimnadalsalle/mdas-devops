
########## BUILDER ##########
FROM alpine:latest AS builder
 
RUN apk update && \
    apk add bash && \
    apk add --no-cache git make musl-dev go

    #apk add github.com/gorilla/websocket && \
    #apk add github.com/go-redis/redis

COPY . .

RUN apk build -o ./build/votingapp && \
    cp -r ui /build

######### RUNTIME #############
FROM alpine:latest
WORKDIR /app
COPY --from=builder build .

ENTRYPOINT [ "./votingapp" ]




