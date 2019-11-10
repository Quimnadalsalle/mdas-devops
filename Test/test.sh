#!/bin/bash
#Test
retry(){
    n=0
    interval=5
    retries=3
    $@ && return 0                                  #$@ refers to all of a shell script’s command-line arguments.
    until [ $n -ge $retries ]                       #-ge is great equal
    do
        n=$(($n+1))
        echo "Retrying...$n of $retries, wait for $interval seconds"
        sleep $interval
        $@ && return 0
    done

    return 1
}

test(){
    curl --url http://${VOTINGAPP_HOST}:8080/vote \
        --request POST \ 
        --data  '{"topics":["dev", "ops"]}' \
        --header "Content-Type: application/json"

    curl --url http://${VOTINGAPP_HOST}:8080/vote \
        --request PUT \ 
        --data  '{"topic":"dev"}'
        --header "Content-Type: application/json"

    winner=(curl --url http://${VOTINGAPP_HOST}:8080/vote \
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

retry test()