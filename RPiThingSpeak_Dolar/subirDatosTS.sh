#!/usr/bin/env bash
#
# Este script sube datos relativos a temperatura, humedad y velocidad del viento
# a un canal de ThingSpeak.
#
# Author: John Sanabria - john.sanabria@correounivalle.edu.co
# Date: 2019-09-04
#
apiKey="2SZA1XIK5IYVZB7K"
device="dev00"

RPiTS_HOME="${HOME}/RPiThingSpeak"
PATH=${RPiTS_HOME}:${PATH}
if [ $# -eq 1 ]; then
  device=${1}
fi

if [ ! -f ${RPiTS_HOME}/${device} ]; then
  echo "[subirDatosTS] ${RPiTS_HOME}/${device} no existe"
  exit -1
fi
precio=$( readWeatherJSON.py ${RPiTS_HOME}/${device}  price )
#humidity=$( readWeatherJSON.py ${RPiTS_HOME}/${device} main humidity )
#wind=$( readWeatherJSON.py ${RPiTS_HOME}/${device} wind speed )

update=$(curl --silent --request POST --header "X-THINGSPEAKAPIKEY: $apiKey" --data "field1=$precio" "http://api.thingspeak.com/update")

if [ ${update} -eq 0 ]; then
  echo "[subirDatosTS] Error al subir datos"
  exit -1
else
  exit 0
fi
