FROM ubuntu:18.04

<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
RUN apt-get update && apt-get install -y \
    curl \
    jq \
    && rm -rf /var/lib/apt/lists/*
=======
RUN apk update && \
    apk add bash && \
    apk add --update python py-pip python-dev && \
    pip install requests
    #&& rm -rf /var/lib/apt/lists/*
COPY test_pipeline.py .
RUN chmod +x test_pipeline.py
>>>>>>> e46e554... containers up, missing to execute them

COPY test.sh .
RUN chmod +x test.sh

ENTRYPOINT ["bash", "-c", "./test.sh" ]
=======
RUN apt-get update && apt-get install -y curl jq && rm -rf /var/lib/apt/lists/*
=======
RUN apk add --update && \
    apk add curl && \
    apk add jq && \
    rm -rf /var/lib/apt/lists/*
>>>>>>> f218e92... Fix due to the understanding of Docker
=======
RUN apt-get update && apt-get install -y curl jq && rm -rf /var/lib/apt/lists/*
>>>>>>> 1aa13c8... Clean changes

COPY test.sh .

RUN chmod +x test.sh

ENTRYPOINT [ "./test.sh" ]
>>>>>>> 2b8b545... Nothing found to let the Application run correctly
