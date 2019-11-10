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
    docker rm -f myvotingapp
    rm -rf build                        #Por si ya tenemos el directorio
    #pkill votingapp || ps aux | grep votingapp | head -1 | awk { 'print $1' } | xargs kill -9    #matas el proceso (sh) por si te lo habias dejado abierto
    #No hace falta matar el proceso, pero si debemos eliminar el container anterior
}

#Build
build(){
    mkdir build                                     #Carpeta para guardar la config
    go build -o ./build ./src/votingapp || exit 1   #Guardas la compilación en build y si va mal se termina la ejecucion
    cp -r ./src/votingapp/ui ./build                #Copiamos los archivos no go

    #pushd build                                     #Cambias de contexto -> es como un cd hasta que haces popd
    #./votingapp &                                   #Con el & ejecutas en background
    docker run --name myvotingapp -v /$(pwd)/build:/app -w //app -p 8080:80 -d ubuntu ./votingapp #-p es para mapear puertos de mi maquina virtual (de todos los containers) a mi container
    #-d te devuelve el control del terminal
    #popd    
}


#Test
test(){
    curl --url http://localhost:8080/vote \
        --request POST \ 
        --data  '{"topics":["dev", "ops"]}' \
        --header "Content-Type: application/json"

    curl --url http://localhost:8080/vote \
        --request PUT \ 
        --data  '{"topic":"dev"}'
        --header "Content-Type: application/json"

    winner=(curl --url http://localhost:8080/vote \
        --request DELETE \ 
        --header "Content-Type: application/json" | jq -r '.winner')    #jq acepta lo de la izquierda y con el -r le envias una query sobre la propiedad de winner

    echo "Winner IS "$winner

    expectedWinner = "dev"

    if ["$expectedWinner" == "$winner"]; then
        echo 'TEST PASSED'
        exit 0
    else
        echo 'TEST FAILED'
        exit 1
    fi
}

deps 
cleanup
GOOS=linux build #compilo para linux porque voy a ejecutar esto en un container
#retry test      #Arriba estara la funcion retry.