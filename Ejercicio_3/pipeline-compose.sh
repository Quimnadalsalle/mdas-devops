#!/bin/bash
pushd ../
docker-compose rm -f && \
docker-compose up --build -d && \
docker-compose run --rm mytest && \
docker-compose push && \
popd
echo "GREEN" || echo "RED"