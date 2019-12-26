#!/bin/bash         
#Pones el hint para que ejecuten el script con este shell (puedes poner sh x ejemplo)

#set -e                              #que el script pare cuando hay un error
#set +e                              #el script sigue aunque haya errores

deps(){
    go get github.com/gorilla/websocket #Dependencia para que funcione el websocket
    go get github.com/labstack/echo     #Dependencia para que funcione echo
}


#Cleanup
cleanup(){
    pkill votingapp || ps aux | grep votingapp | head -1 | awk '{print $1}' | xargs kill -9    #matas el proceso (sh) por si te lo habias dejado abierto
    rm -rf build                        #Por si ya tenemos el directorio
}

#Build
build(){
    mkdir build                                     #Carpeta para guardar la config
    go build -o ./build ../src/votingapp || exit 1   #Guardas la compilación en build y si va mal se termina la ejecucion
    cp -r ../src/votingapp/ui ./build                #Copiamos los archivos no go

    pushd build                                     #Cambias de contexto -> es como un cd hasta que haces popd
    ./votingapp &                                   #Con el & ejecutas en background
    popd    
}
#Test
test(){
    python test_pipeline.py
}

deps 
cleanup
build
test
    
