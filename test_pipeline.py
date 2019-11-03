import requests
import json

url = 'http://localhost/vote'
headers = "{'Content-type': 'application/json'}"
data1 = "'topics':['dev', 'ops']"
data2 = '{"topic":"dev"}'

try:
    request1=requests.post(url, data=data1, headers=headers)
    request2=requests.put(url, data=data2, headers=headers)
    result=requests.get(url, ".winner", headers=headers)
    request3=requests.delete(url)

    print("The winner is " + str(result))

    expectedWinner = "dev"

    if expectedWinner == str(result):
        print("Test passed")
    else:
        print("Test not passed")
except Exception as e:
    print ("We've got an error")
    raise e