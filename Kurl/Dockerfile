#Layer de la qual vamos a partir
FROM ubuntu:18.04 
#cada run hace un commit y tendremos un nuevo layer (layer/run)
#Hago update, install y borro los archivos basura
RUN apt-get update && apt-get install curl -y && rm -rf /var/lib/apt/lists/*
#sOBREESCRIBO EL ENTRY POINT DE BASH (de ubuntu) DICES QUE PROCESO SE VA A EJECUTAR
ENTRYPOINT [ "curl" ]