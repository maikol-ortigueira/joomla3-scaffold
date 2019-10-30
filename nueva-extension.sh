#!/bin/bash

RUTA_CARPETAS=~/Escritorio/repositorios/joomla3-scaffold;

clear

stty erase '^?'
echo
echo "Bienvenido a la automatización de carpetas para Joomla3!"
echo
echo
echo "No te olvides de que debes estar dentro del directorio de nuestro proyecto."
echo
echo "Y más importante aún, estar seguro de tener instalado unzip. sudo apt-get install unzip"
echo
echo -n "Todo correcto? Continuar (s/n) "
read sample

if [ "$sample" = "n" ]; then
	exit
fi
# echo
# echo -n "Bajar última versión de JoomlaPro Scaffold? Continuar? (s/n) Obs: Es necesario tener una versión. Si no la tiene, bájela. Si ya la tiene prosiga."
# read version

# if [ "$version" = "s" ]; then
# 	echo
# 	echo "Donloading package..."
# 	echo
# 	sudo rm -rf master.zip
# 	wget https://github.com/joomlapro/joomla3-scaffold/archive/master.zip
# 	echo "El archivo master.zip se mantendrá en su carpeta principal del proyecto, para que pueda crear cuantos módulos, plantillas, o componentes quiera."
# 	echo "En caso de querer actualizarlo, en la opción anterior baje la última versión del servidor de JoomlaPro"
# 	echo "done!"
# fi

# echo
# echo "Extracting data..."
# echo
# unzip -o master.zip
# echo "done!"

echo
echo -n "Tipo de extensión a generar? 1-módulo, 2-componente"
echo
read scaffold



### MODULO
if [ "$scaffold" = "1" ]; then
	echo
	echo "Now installing Joomla3 module files..."

	echo
	echo -n "Cual es el nombre del módulo? ex: login, menu, feed, (siempre en singular)"
	echo
	read modulo

	echo
	echo -n "Para donde quieres crear el módulo? 1-administración 2-sitio"
	echo
	read donde
	if [ "$donde" = "1" ]; then
		cp -R ${RUTA_CARPETAS}/modules/admin/mod_{{module}} ./mod_$modulo
		find ./mod_$modulo -name "*{{module}}*" | rename "s/\{\{module\}\}/$modulo/"
	fi
	if [ "$donde" = "2" ]; then
		cp -R ${RUTA_CARPETAS}/modules/site/mod_{{module}} ./mod_$modulo
		find ./mod_$modulo -name "*{{module}}*" | rename "s/\{\{module\}\}/$modulo/"
	fi


	echo "Creando carpetas para el módulo"
	echo "."
	clear
	echo
	echo
	echo "-------------------------------------------------------------------------"
	echo "** Las carpetas de tu nuevo módulo se han creado perfectamente. Adios. **"
	echo "-------------------------------------------------------------------------"
	echo
	echo "Ahora puedes recorrer cada uno de los archivos del módulo, y empezar a hacer uso de los snippets."
	echo "Para ello deberás tener instalado el paquete de snippets \"joomla3-sublime-snippets\"."
	echo "Si no es así, deberás ir a tu sublime pulsar shft+ctrl+p, luego 'Package Control: Add Repository'"
	echo "Añadir la URL: 'https://github.com/maikol-ortigueira/joomla3-sublime-snippets' y pulsar intro."
	echo "Ahora otra vez shft+ctrl+p, 'Package Control: Install Package'"
	echo "Buscar 'joomla3-sublime-snippets'"
	echo
	echo "Para utilizar los snippets solo tienes que ir a cada uno de los ficheros, colocarse al final de cada snippet y pulsar tab"
	echo
	echo
fi

### COMPONENTE
if [ "$scaffold" = "2" ]; then
	echo
	echo "Instalando archivos para crear un componente..."

	echo
	echo -n "Cual es el nombre del componente? (Siempre en singular): "
	echo
	read componente

	cp -R ${RUTA_CARPETAS}/components/com_{{component}} ./com_$componente
	find ./com_$componente -name "*{{component}}*" | rename "s/\{\{component\}\}/$componente/"
	echo
	clear

	echo
	echo -n "Cual es el nombre singular de la vista principal?: "
	echo
	read singular

	find ./com_$componente -name "*{{singular}}*" | rename "s/\{\{singular\}\}/$singular/"
	echo
	clear

	echo
	echo -n "Cual es el nombre plural de la vista principal?: "
	echo
	read plural

	find ./com_$componente -name "*{{plural}}*" | rename "s/\{\{plural\}\}/$plural/"
	echo
	clear



	echo
	echo
	echo "-----------------------------------------------------------------------------"
	echo "** Las carpetas de tu nuevo componente se han creado perfectamente. Adios. **"
	echo "-----------------------------------------------------------------------------"
	echo
	echo
	echo "Ahora puedes recorrer cada uno de los archivos del compoente, y empezar a hacer uso de los snippets."
	echo "Para ello deberás tener instalado el paquete de snippets \"joomla3-sublime-snippets\"."
	echo "Si no es así, deberás ir a tu sublime pulsar shft+ctrl+p, luego 'Package Control: Add Repository'"
	echo "Añadir la URL: 'https://github.com/maikol-ortigueira/joomla3-sublime-snippets' y pulsar intro."
	echo "Ahora otra vez shft+ctrl+p, 'Package Control: Install Package'"
	echo "Buscar 'joomla3-sublime-snippets'"
	echo
	echo "Para utilizar los snippets solo tienes que ir a cada uno de los ficheros, colocarse al final de cada snippet y pulsar tab"
	echo
	echo
fi