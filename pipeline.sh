#!/bin/bash         
#Pones el hint para que ejecuten el script con este shell (puedes poner sh x ejemplo)

#set -e                              #que el script pare cuando hay un error
#set +e                              #el script sigue aunque haya errores

go get github.com/gorilla/websocket #Dependencia para que funcione el websocket
go get github.com/labstack/echo     #Dependencia para que funcione echo

#Cleanup
rm -rf build                        #Por si ya tenemos el directorio

#Build
mkdir build                                     #Carpeta para guardar la config
go build -o ./build ./src/votingapp || exit 1   #Guardas la compilación en build y si va mal se termina la ejecucion

cp -r ./src/votingapp/ui ./build                #Copiamos los archivos no go
