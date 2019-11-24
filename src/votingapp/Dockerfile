
########## BUILDER ##########
FROM alpine:latest AS builder
 
RUN apk update && \
    apk add bash && \
    apk add --no-cache git make musl-dev go

RUN go get github.com/gorilla/websocket && \
    go get github.com/go-redis/redis && \
    go get github.com/labstack/echo
  

COPY . .
RUN go build -o ./build/votingapp && \
    cp -r ui /build

######### RUNTIME #############
FROM alpine:latest
WORKDIR /app
COPY --from=builder build .

ENTRYPOINT [ "./votingapp" ]




