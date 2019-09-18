Monitoreo del comportamiento del Dòlar en una jornada de comercio

Para esta practica se monitorea la pagina web Set-fx.com que presenta un dato actualizado en tiempo real, de las variaciones del valor del dólar durante una jornada de intercambio.

Para ello se usan como base los archivos de la práctica anterior, y se hacen modificaciones en los siguientes archivos:

openWeather.sh -> ahora -> openPage.sh
	curl "http://www.set-fx.com/stats"

readSensor.sh -> ahora -> readPage.sh
	se hacen los cambios respectivos a los cambios de nombres de archivos

readWeatherJSON.py -> ahora -> readWeatherJSON.py
	se hacen los cambios respectivos a los cambios de nombres de archivos

subirDatosTS.sh -> igual -> subirDatosTS.sh
	se hacen los cambios respectivos a los cambios de nombres de archivos

La pagina http://www.set-fx.com/stats devuelve un archivo JSON de donde se puede recoger el dato ‘price’ que varía durante la jornada de acuerdo al valor que el mercado le asigna a la divisa
