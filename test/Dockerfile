FROM alpine:latest

RUN apk add --update && \
    apk add curl && \
    apk add jq && \
    rm -rf /var/lib/apt/lists/*

COPY test.sh .

RUN chmod +x test.sh

ENTRYPOINT [ "./test.sh" ]