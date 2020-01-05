# MDAS Devops tools: Scripting, Pipelines,  Docker, Kubernetes

## **Cross Platform Setup (Windows, Mac or Linux)**

### Download and install

* [Visual Studio Code](https://code.visualstudio.com/download)
  * Plugins: Go, Python, Docker
* [Git](https://git-scm.com/downloads)
* [Docker](https://www.docker.com/products/docker-desktop)
* [Golang](https://golang.org/dl/)
* [Python](https://www.python.org/downloads/)
* [jq](https://stedolan.github.io/jq/download/)
* [Minikube](https://kubernetes.io/docs/tasks/tools/install-minikube/)

### Signup for

* [Dockerhub](https://hub.docker.com)
* [Github](https://github.com)
* [Azure Education](https://azureforeducation.microsoft.com/devtools)

# Indice para corregir:
## Ejercicio 1 - Pipelines
En la rama **develop-until-it-compiles**
En la carpeta Ejercicio 1:  
Ejecutar **pipeline.sh** para levantar el servicio y ejecutar los tests.  
El test está en **test_pipeline.py**  
## Ejercicio 2 - Dockerizar votingapp + tests
En la rama: **pipeline_docker_alpine_v2**  
Ejecutamos la pipeline en la carpeta Ejercicio_2: **pipeline_docker_alpine.sh**  
En **./src/votingapp** está el Dockerfile basado en alpine para ejecutar la app en un container  
En **./test** está el Dockerfile para ejecutar el test de Python en un container  
## Ejercicio 3a - Docker Compose - Nueva Imagen Nginx
En la rama: **ejercicio_3_docker_compose_nginx**
Ejecutamos la pipeline en la carpeta Ejercicio_3: **pipeline_compose.sh**
La pipeline me sale en RED porque no me deja pushear las imagenes con el docker-compose push.
Si me deja hacer push de cada imagen por separado (votingapp, votingapp_test & nginx)
## Ejercicio 3b - Docker Compose - Imagen Nginx config en volumen
