#!/bin/bash
#El build lo hago en el compose
docker-compose rm -f && \
docker-compose up --build -d && \
#docker-compose run --rm mytest && \
docker-compose push && \


#Deploy en kubernetes
kubectl apply -f votingapp.yaml && \

Kubectl run mytests \
--generator=run-pod/v1 \
--image=quimnadal/votingapp-test \
--env VOTINGAPP_HOST=myvotingapp.votingapp \
#(servicename.namespace)
--rm --attach --restart= Never && \
#(--rm es para eliminarse al acabar, --attach para que me de el resultado de la ejecución)

echo "GREEN" || echo "RED"