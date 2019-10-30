#!/bin/bash

# Script para crear las carpetas de una vista nueva de joomla
# Para donde es la vista: administración o sitio
# Nombre de la vista en singular
# Nombre de la vista en plural
# Carpeta de destino. Lo lógico es que se guarde en una carpeta
# con el nombre del componente y del que cuelgan admin, site y media
# Especificar esto en el texto del cuadro al pedir el destino.

# Ruta en donde se encuentran las carpetas a copiar
RUTA_COPIA=~/Escritorio/repositorios/joomla3-scaffold/components/com_{{component}};


# Nota para el usuario
zenity --question \
		--no-wrap \
		--text="Este script te creará las carpetas necesarias para tu nueva vista.\nLos datos que se te pedirán son:\n\n\t- Destino de la vista.\n\t- Nombre de la vista\n\t- Carpeta de destino.\n\nDeseas continuar?";
case $? in
	1)
		echo "Adios, otra vez será!!.";
		exit;;
	-1)
		echo "Ha ocurrido un error inesperado.";;
esac

#Pedimos la carpeta de destino
TIPO=$(zenity \
		--list \
		--title="Destino" \
		--radiolist \
		--column="" --column="Destino" \
		TRUE "admin" FALSE "site");

case $? in
	1)
		echo "Como no has escogido destino de la vista entiendo que quieres terminar.";
		exit;;
	-1)
		echo "Ha ocurrido un error inesperado.";;
esac

# Pedimos los nombre de la vista, en singular y en plural
NOMBRE=`zenity	--forms \
		--title="Nombre de la vista" \
		--text="Nombre singular y plural" \
		--separator="," \
		--add-entry="Singular" \
		--add-entry="Plural"`;
		
# Paso los datos introducidos a minúscula
NOMBRE=${NOMBRE,,};

# Asignamos los valores pasados a sus respectivas variables.
SINGULAR=$(awk -F, '{print $1}' <<<$NOMBRE);
PLURAL=$(awk -F, '{print $2}' <<<$NOMBRE);

case $? in
	1)
		echo "Adios, otra vez será!!.";
		exit;;
	-1)
		echo "Ha ocurrido un error inesperado.";;
esac


# Tenemos que informar al usuario que la carpeta raiz debe ser com_"nombre de la extensión"
zenity --info \
		--no-wrap \
		--text="A continuación se te pedirá la carpeta de destino de la vista.\n\nEsta carpeta deberá ser la raiz del componente.\nes decir, el com_'nombre-del-componente'.";
cd ~/Escritorio/extensiones/componentes;

# Pedimos la carpeta de destino de la nueva vista
RUTA_CARPETA=$(zenity --file-selection --title="Selecciona la carpeta de destino" --directory);
cd ${RUTA_CARPETA};

case $? in
	1)
		echo "Sin Carpeta no podemos crear la vista, adios!!.";
		exit;;
	-1)
		echo "Ha ocurrido un error inesperado.";;
esac

# Con los datos introducidos realizamos las copias a carpetas destino
case $TIPO in
	admin)
	# Si han seleccionado vistas en la administración
		cp ${RUTA_COPIA}/$TIPO/controllers/{{plural}}.php ./$TIPO/controllers/${PLURAL}.php;
		cp ${RUTA_COPIA}/$TIPO/controllers/{{singular}}.php ./$TIPO/controllers/${SINGULAR}.php;
		cp ${RUTA_COPIA}/$TIPO/models/fields/modal/{{singular}}.php ./$TIPO/models/fields/modal/${SINGULAR}.php;
		cp ${RUTA_COPIA}/$TIPO/models/forms/filter_{{plural}}.xml ./$TIPO/models/forms/filter_${PLURAL}.xml;
		cp ${RUTA_COPIA}/$TIPO/models/forms/{{singular}}.xml ./$TIPO/models/forms/${SINGULAR}.xml;
		cp ${RUTA_COPIA}/$TIPO/models/{{plural}}.php ./$TIPO/models/${PLURAL}.php;
		cp ${RUTA_COPIA}/$TIPO/models/{{singular}}.php ./$TIPO/models/${SINGULAR}.php;
		cp ${RUTA_COPIA}/$TIPO/tables/{{singular}}.php ./$TIPO/tables/${SINGULAR}.php;
		cp -R ${RUTA_COPIA}/$TIPO/views/{{plural}} ./$TIPO/${PLURAL};
		cp -R ${RUTA_COPIA}/$TIPO/views/{{singular}} ./$TIPO/${SINGULAR};;
	site)
	# Si han seleccionado vista en el sitio
		cp ${RUTA_COPIA}/$TIPO/controllers/{{singular}}.php ./$TIPO/controllers/${SINGULAR}.php;
		cp ${RUTA_COPIA}/$TIPO/models/forms/{{singular}}.xml ./$TIPO/models/forms/${SINGULAR}.xml;
		cp ${RUTA_COPIA}/$TIPO/models/{{plural}}.php ./$TIPO/models/${PLURAL}.php;
		cp ${RUTA_COPIA}/$TIPO/models/{{singular}}.php ./$TIPO/models/${SINGULAR}.php;
		cp -R ${RUTA_COPIA}/$TIPO/views/{{plural}} ./$TIPO/${PLURAL};
		cp -R ${RUTA_COPIA}/$TIPO/views/{{singular}} ./$TIPO/${SINGULAR};;
esac

#FIN


