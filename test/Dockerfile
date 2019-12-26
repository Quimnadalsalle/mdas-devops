FROM alpine:latest


RUN apk update && \
    apk add bash && \
    apk add --update python py-pip python-dev && \
    pip install requests

COPY test_pipeline.py .
CMD [ "python", "./test_pipeline.py" ]
