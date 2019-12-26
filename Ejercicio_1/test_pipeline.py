import requests
import json
import time

url = 'http://localhost/vote'
data1 = {'topics':['dev', 'ops']}
data2 = {'topic':'dev'}
params = 'winner'
n=2
for i in range (1,4):
    try:
        request1=requests.post(url, data=data1) #pasar los datos como diccionario y luego pasarlo a json, no como string 
        request2=requests.put(url, json=data2)
        request3=requests.delete(url)
        result=requests.get(url).json()

        print("The winner is " + str(result[params]))

        expectedWinner = "dev"

        if expectedWinner == str(result[params]):
            print("Test passed")
            
            break
        else:
            print("Test not passed")

    except Exception:
        print ("We've got an error. "+str(i)+ "/3 attempt completed. Waiting "+str(n)+ " seconds...")
        time.sleep(n)
        n *= 2
        if i == 3:
            print ("Test defintely failed")
        