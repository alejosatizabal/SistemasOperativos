#!/usr/bin/env bash
#
# Este script se encarga de guardar en un archivo los datos de temperatura,
# viento y humedad de Cali en format JSON.
#
# El script espera un argumento que será el nombre del archivo se almacenaran
# los datos de temperatura, humedad y velocidad del viento
#
# Author: John Sanabria - john.sanabria@correounivalle.edu.co
# Date: 2019-09-04
#

leerSensor() { 
  echo "[readSensor] leyendo sensor"
  epoch=$( date +'%s')
  openWeather.sh > dolar_${epoch}.json
}

if [ ! $# -eq 1 ]; then
        echo "[readSensor] ${0} <filename>"
        exit -1
fi

RPiTS_HOME="${HOME}/RPiThingSpeak"
PATH=${RPiTS_HOME}:${PATH}
cd ${RPiTS_HOME}
FILENAME=${1}

# Se valida si ya existe un archivo donde se haya guardado una lectura de
# temperatura anterior, dolar_<EPOCH>.json
EXISTFILE=$(ls -l *.json | grep dolar_ | wc -l | awk '{print $1}')
if [ ${EXISTFILE} -eq 1 ]; then # Se encontro un archivo dolar_*.json
  echo "[readSensor] Se encontro archivo"
  EPOCH=$( ls *.json | grep dolar_ | cut -d '_' -f 2 | cut -d '.' -f 1)
  CURRENTEPOCH=$( date +'%s')
else
  echo "[readSensor] No se encontro archivo"
  leerSensor
  cat dolar_*.json > ${FILENAME}
  rm dolar_*.json
  exit 0
fi

if [ $(( CURRENTEPOCH - EPOCH )) -lt 60 ]; then # El dato aun es vigente
  echo "[readSensor] Dato vigente"
  cat dolar_*.json > ${FILENAME}
  exit 0
fi
# Datos mayores a 5 minutos, desactualizados
echo "[readSensor] Dato desactualizado"
rm dolar_*.json
leerSensor
exit 0
