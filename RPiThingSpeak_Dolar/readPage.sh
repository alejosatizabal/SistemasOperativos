#!/usr/bin/env bash
#
#

leerPage() { 
  echo "[readPage] leyendo pagina"
  epoch=$( date +'%s')
  openPage.sh > dolar_${epoch}.json
}

if [ ! $# -eq 1 ]; then
        echo "[readPage] ${0} <filename>"
        exit -1
fi

RPiTS_HOME="${HOME}/RPiThingSpeak"
PATH=${RPiTS_HOME}:${PATH}
cd ${RPiTS_HOME}
FILENAME=${1}

EXISTFILE=$(ls -l *.json | grep dolar_ | wc -l | awk '{print $1}')
if [ ${EXISTFILE} -eq 1 ]; then # Se encontro un archivo dolar_*.json
  echo "[readPage] Se encontro archivo"
  EPOCH=$( ls *.json | grep dolar_ | cut -d '_' -f 2 | cut -d '.' -f 1)
  CURRENTEPOCH=$( date +'%s')
else
  echo "[readPage] No se encontro archivo"
  leerPage
  cat dolar_*.json > ${FILENAME}
  rm dolar_*.json
  exit 0
fi

if [ $(( CURRENTEPOCH - EPOCH )) -lt 60 ]; then # El dato aun es vigente
  echo "[readPage] Dato vigente"
  cat dolar_*.json > ${FILENAME}
  exit 0
fi
# Datos mayores a 5 minutos, desactualizados
echo "[readPage] Dato desactualizado"
rm dolar_*.json
leerPage
exit 0
