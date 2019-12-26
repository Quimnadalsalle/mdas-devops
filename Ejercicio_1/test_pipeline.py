import requests
import json

url = 'http://localhost/vote'
data1 = {'topics':['dev', 'ops']}
data2 = {'topic':'dev'}
params = 'winner'
try:
    request1=requests.post(url, data=data1).json() #pasar los datos como diccionario y luego pasarlo a json, no como string 
    request2=requests.put(url, json=data2)
    request3=requests.delete(url)
    result=requests.get(url).json()

    print("The winner is " + str(result[params]))

    expectedWinner = "dev"

    if expectedWinner == str(result[params]):
        print("Test passed")
    else:
        print("Test not passed")

except Exception as e:
    print ("We've got an error")
    raise e