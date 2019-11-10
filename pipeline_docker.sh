#!/bin/bash         
#Pones el hint para que ejecuten el script con este shell (puedes poner sh x ejemplo)

#set -e                              #que el script pare cuando hay un error
#set +e                              #el script sigue aunque haya errores

#Cleanup
docker network create votingapp

docker rm -f myvotingapp

#No hace falta matar el proceso, pero si debemos eliminar el container anterior

#Build

docker build \
#-f ./src/votingapp/Dockerfile /
-t quimnadal/votingapp \
./src/votingapp

docker run \
--name myvotingapp \
--network votingapp \
-p 8080:80 \
-d quimnadal/votingapp                #Copiamos los archivos no go 

docker build \
-t quimnadal/votingapp-test \
./test

docker run --rm -e VOTINGAPP_HOST="myvotingapp" /
--network votingapp /
quimnadal/votingapp-test

docker push quimnadal/votingapp