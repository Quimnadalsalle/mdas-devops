FROM alpine:latest

RUN apk update && \
    apk add bash && \
    apk add --update python py-pip python-dev && \
    pip install requests
    #&& rm -rf /var/lib/apt/lists/*
COPY test_pipeline.py .
RUN chmod +x test_pipeline.py

ENTRYPOINT [ "bash", "-c", "./test_pipeline.py" ]