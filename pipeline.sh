<<<<<<< HEAD
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
    go build -o ./build ./src/votingapp || exit 1   #Guardas la compilación en build y si va mal se termina la ejecucion
    cp -r ./src/votingapp/ui ./build                #Copiamos los archivos no go

    pushd build                                     #Cambias de contexto -> es como un cd hasta que haces popd
    ./votingapp &                                   #Con el & ejecutas en background
    popd    
}

retry(){
    n=0
    interval=5
    retries=3
    $@ && return 0                                  #$@ refers to all of a shell script’s command-line arguments.
    until [ $n -ge $retries ]                       #-ge is great equal
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
    votingurl='http://localhost/vote'
    curl --url $votingurl \
        --request POST \
        --data  '{"topics":["dev", "ops"]}' \
        --header "Content-Type: application/json"

    curl --url $votingurl \
        --request PUT \
        --data  '{"topic":"dev"}' \
        --header "Content-Type: application/json"

    winner=$(curl --url $votingurl \
        --request DELETE \
        --header "Content-Type: application/json" | jq -r '.winner')    #jq acepta lo de la izquierda y con el -r le envias una query sobre la propiedad de winner

    echo "Winner IS "$winner

    expectedWinner="dev"

    if [ "$expectedWinner" == "$winner" ]; then
        echo 'TEST PASSED'
        exit 0
    else
        echo 'TEST FAILED'
        exit 1
    fi
}

deps 
cleanup
build
retry test      #Arriba estara la funcion retry.
    
=======
#!/bin/bash
set -e

# install deps
deps(){
    go get github.com/gorilla/websocket
    go get github.com/labstack/echo
}

# cleanup
cleanup(){
    pkill votingapp || ps aux | grep votingapp | awk {'print $1'} | head -1 | xargs kill -9
    rm -rf build || true
}

# build 
<<<<<<< HEAD
mkdir build
go build -o ./build ./src/votingapp 
cp -r ./src/votingapp/ui ./build
>>>>>>> c3e7793... super simple pipeline
=======
build(){
    mkdir build
    go build -o ./build ./src/votingapp 
    cp -r ./src/votingapp/ui ./build

    pushd build
    ./votingapp &
    popd
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

# test
test() {
    votingurl='http://localhost/vote'
    curl --url  $votingurl \
        --request POST \
        --data '{"topics":["dev", "ops"]}' \
        --header "Content-Type: application/json" 

    curl --url $votingurl \
        --request PUT \
        --data '{"topic": "dev"}' \
        --header "Content-Type: application/json" 
    
    winner=$(curl --url $votingurl \
        --request DELETE \
        --header "Content-Type: application/json" | jq -r '.winner')

    echo "Winner IS "$winner

    expectedWinner="dev"

    if [ "$expectedWinner" == "$winner" ]; then
        echo 'TEST PASSED'
        return 0
    else
        echo 'TEST FAILED'
        return 1
    fi
}

deps
cleanup
build
retry test
>>>>>>> 2b90b58... siguiente clase
