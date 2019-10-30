#!/bin/bash

CARPETA_JOOMLA=/var/www/html/
CARPETA_COMPONENTE=~/Escritorio/extensiones/componentes

# Función que crea enlaces simbolicos en $2 de $1
function enlazaSibolicamenteJoomla()
{
	# $1 es la ruta a donde voy a enlazar
	# $2 es la ruta en donde voy a colocar el enlace
	ln -s $1 $2
}

# Función para pedir datos por pantalla
# $1 Texto que aparece en la pregunta
function pideTexto()
{
	resultado=$(zenity \
				--entry \
				--text="$1")
}

# Funcion para pedir ruta de una carpeta
# $1 Texto que aparece en la pregunta
function pideCarpeta()
{
	resultado=$(zenity \
		--file-selection \
		--title="$1" \
		--directory
	)
}

clear
echo '		--------------------------------------------------'
echo '		--- Indícanos primero la carpeta de tu joomla! ---'
echo '		--------------------------------------------------'
cd ${CARPETA_JOOMLA}
pideCarpeta 'Selecciona Carpeta de tu Joomla!'
CARPETA_JOOMLA=$resultado

clear
echo '		----------------------------------------------------'
echo '		--- Indícanos ahora la carpeta de tu componente! ---'
echo '		----------------------------------------------------'
cd ${CARPETA_COMPONENTE}
pideCarpeta 'Selecciona Carpeta de tu Joomla!'
CARPETA_COMPONENTE=$resultado

clear
echo '		----------------------------------------------------'
echo '		-----  Indícanos el nombre de tu componente!   -----'
echo '		----------------------------------------------------'
cd ~/Escritorio/
pideTexto 'Nombre del Componente sin prefijo'

NOMBRE_COMPONENTE=$resultado
NOMBRE_COMPONENTE=${$NOMBRE_COMPONENTE,,}

COMPONENTE=com_${NOMBRE_COMPONENTE}

clear

CARPETA_ADMIN_S1=${CARPETA_COMPONENTE}/admin/
CARPETA_SITE_S1=${CARPETA_COMPONENTE}/site/
CARPETA_MEDIA_S1=${CARPETA_COMPONENTE}/media/
CARPETA_ADMIN_LANGUAGE_en_GB_S1=${CARPETA_COMPONENTE}/admin/language/en-GB/en-GB.$COMPONENTE.ini
CARPETA_ADMIN_LANGUAGE_en_GB_S1_sys=${CARPETA_COMPONENTE}/admin/language/en-GB/en-GB.$COMPONENTE.sys.ini
#CARPETA_ADMIN_LANGUAGE_es_ES_S1=${CARPETA_COMPONENTE}/admin/language/es-ES/es-ES.$COMPONENTE.ini
#CARPETA_ADMIN_LANGUAGE_es_ES_S1_sys=${CARPETA_COMPONENTE}/admin/language/es-ES/es-ES.$COMPONENTE.sys.ini
CARPETA_SITE_LANGUAGE_en_GB_S1=${CARPETA_COMPONENTE}/site/language/en-GB/en-GB.$COMPONENTE.ini
#CARPETA_SITE_LANGUAGE_es_ES_S1=${CARPETA_COMPONENTE}/site/language/es-ES/es-ES.$COMPONENTE.ini

CARPETA_ADMIN_S2=${CARPETA_JOOMLA}/administrator/components/$COMPONENTE
CARPETA_SITE_S2=${CARPETA_JOOMLA}/components/$COMPONENTE
CARPETA_MEDIA_S2=${CARPETA_JOOMLA}/media/$COMPONENTE
CARPETA_SITE_LANGUAGE_en_GB_S2=${CARPETA_JOOMLA}/language/en-GB/
#CARPETA_SITE_LANGUAGE_es_ES_S2=${CARPETA_JOOMLA}/language/es-ES/
CARPETA_ADMIN_LANGUAGE_en_GB_S2=${CARPETA_JOOMLA}/administrator/language/en-GB/
#CARPETA_ADMIN_LANGUAGE_es_ES_S2=${CARPETA_JOOMLA}/administrator/language/es-ES/

# Primero borrar si ya existen los enlaces

enlazaSibolicamenteJoomla $CARPETA_ADMIN_S1 $CARPETA_ADMIN_S2
enlazaSibolicamenteJoomla $CARPETA_SITE_S1 $CARPETA_SITE_S2
enlazaSibolicamenteJoomla $CARPETA_MEDIA_S1 $CARPETA_MEDIA_S2
enlazaSibolicamenteJoomla $CARPETA_ADMIN_LANGUAGE_en_GB_S1 $CARPETA_ADMIN_LANGUAGE_en_GB_S2
enlazaSibolicamenteJoomla $CARPETA_ADMIN_LANGUAGE_en_GB_S1_sys $CARPETA_ADMIN_LANGUAGE_en_GB_S2
enlazaSibolicamenteJoomla $CARPETA_SITE_LANGUAGE_en_GB_S1 $CARPETA_SITE_LANGUAGE_en_GB_S2

