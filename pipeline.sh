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
=======
#!/bin/bash
set -e

# install deps
deps(){
    go get github.com/gorilla/websocket
    go get github.com/labstack/echo
    go get github.com/go-redis/redis
}

# cleanup
cleanup(){
    pkill votingapp || ps aux | grep votingapp | awk {'print $1'} | head -1 | xargs kill -9
    rm -rf build
}

# build 
build(){
    mkdir build
    go build -o ./build ./src/votingapp 
    cp -r ./src/votingapp/ui ./build

    docker run -p 6379:6379 -d redis || true
    pushd build
    ./votingapp &
    popd
>>>>>>> acb024874f080c03ab3796195a4b94b7d8210770
}

retry(){
    n=0
    interval=5
    retries=3
<<<<<<< HEAD
    $@ && return 0                                  #$@ refers to all of a shell script’s command-line arguments.
    until [ $n -ge $retries ]                       #-ge is great equal
    do
        n=$[$n+1]
=======
    $@ && return 0
    until [ $n -ge $retries ]
    do
        n=$(($n+1))
>>>>>>> acb024874f080c03ab3796195a4b94b7d8210770
        echo "Retrying...$n of $retries, wait for $interval seconds"
        sleep $interval
        $@ && return 0
    done

    return 1
}
<<<<<<< HEAD
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
=======

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
>>>>>>> acb024874f080c03ab3796195a4b94b7d8210770

    echo "Winner IS "$winner

    expectedWinner="dev"

    if [ "$expectedWinner" == "$winner" ]; then
        echo 'TEST PASSED'
<<<<<<< HEAD
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
<<<<<<< HEAD
=======
#!/bin/bash
set -e

# install deps
deps(){
    go get github.com/gorilla/websocket
    go get github.com/labstack/echo
    go get github.com/go-redis/redis
}

# cleanup
cleanup(){
    pkill votingapp || ps aux | grep votingapp | awk {'print $1'} | head -1 | xargs kill -9
    rm -rf build
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

    docker run -p 6379:6379 -d redis || true
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
        n=$(($n+1))
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
>>>>>>> pipeline_docker_alpine_v2
        return 0
    else
        echo 'TEST FAILED'
        return 1
    fi
}

deps
cleanup || true
build
retry test
<<<<<<< HEAD
>>>>>>> acb024874f080c03ab3796195a4b94b7d8210770
=======
>>>>>>> 2b90b58... siguiente clase
>>>>>>> pipeline_docker_alpine_v2
