#!/bin/bash         

deps(){
    go get github.com/gorilla/websocket #Dependencia para que funcione el websocket
    go get github.com/labstack/echo     #Dependencia para que funcione echo
}


#Cleanup
cleanup(){
    docker rm -f myvotingapp
    rm -rf build                        #Por si ya tenemos el directorio
}

#Build
build(){
    mkdir build                                     #Carpeta para guardar la config
    go build -o ./build ./src/votingapp             #Guardas la compilación en build
    cp -r ./src/votingapp/ui ./build                #Copiamos los archivos no go
    docker run --name myvotingapp -p 8080:80 -d quimnadal/votingapp
    #Runeo votingapp
}

retry(){
    n=0
    interval=5
    retries=3
    $@ && return 0
    until [ $n -ge $retries ]
    do
        n=$[$n+1]
        echo "Retrying...$n of $retries, wait for $interval seconds"
        sleep $interval
        $@ && return 0
    done

    return 1
}

#Test
test(){
    curl --url http://localhost:8080/vote \
        --request POST \
        --data  '{"topics":["dev", "ops"]}' \
        --header "Content-Type: application/json"

    curl --url http://localhost:8080/vote \
        --request PUT \
        --data  '{"topic":"dev"}' \
        --header "Content-Type: application/json"

    winner=$(curl --url http://localhost:8080/vote \
        --request DELETE \
        --header "Content-Type: application/json" | jq -r '.winner')

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
cleanup || true
GOOS=linux build #compilo para linux porque voy a ejecutar esto en un container
retry test      #Arriba estara la funcion retry.

docker push quimnadal/votingapp