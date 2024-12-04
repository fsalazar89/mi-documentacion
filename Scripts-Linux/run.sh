#!/bin/bash

# Verificar si se proporciona al menos un parámetro
if [ $# -eq 0 ]; then
    echo "No se proporcionó ningún parámetro."
    echo "Debe pasa como parametro el ambiente en el que desea desplegar"
    echo "Para produccion: sh run.sh \"prod\""
    echo "Para pruebas: sh run.sh \"qa\""
    exit 1
fi
fecha_actual=$(date +"%Y-%m-%d-%H-%M-%S")
opcion=$1

# Verificar la elección del usuario y ejecutar acciones correspondientes
if [ "$opcion" = "qa" ]; then # desplegamos en QA

    echo "Despliegue en ambiente QA"

    echo "Deteniendo el contenedor nombre-del-contenedor ...."
    docker stop nombre-del-contenedor

    echo "Eliminando el contenedor nombre-del-contenedor ...."
    docker rm nombre-del-contenedor

    echo "Eliminando volumenes asociados al contenedor nombre-del-contenedor ..."
    docker volume rm nombre-del-contenedor

    echo "Eliminando la imagen nombre-del-contenedor ...."
    docker rmi nombre-de-la-imagen

    echo "Generando la nueva imagen con los cambios ...."
    npm run docker_build

    echo "Generando el nuevo contenedor con los cambios ...."
    npm run docker_qa


elif [ "$opcion" = "prod" ]; then

    echo "Despliegue en ambiente PRODUCTIVO"

    echo "Deteniendo el contenedor nombre-del-contenedor ...."
    docker stop nombre-del-contenedor

    echo "Eliminando el contenedor nombre-del-contenedor ...."
    docker rm nombre-del-contenedor

    echo "Eliminando volumenes asociados al contenedor nombre-del-contenedor ..."
    docker volume rm nombre-del-contenedor

    echo "Eliminando la imagen nombre-de-la-imagen ...."
    docker rmi nombre-de-la-imagen

    echo "Generando la nueva imagen con los cambios ...."
    npm run docker_build

    echo "Generando el nuevo contenedor con los cambios ...."
    npm run docker_prod

else
  echo "Opción no válida. Por favor, Solo opción \"qa\" o \"prod\""
fi