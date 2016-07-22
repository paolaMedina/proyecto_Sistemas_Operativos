#!/bin/bash


# Este archivo ejecuta una serie de comandos en bash, para imprimir en pantalla algunos datos de una maquina virtual  
#creada en VirtualBox


#Se obtiene el numero de Cpus de la maquina virtual y se imprime por pantalla.
numero_de_CPUs=`VBoxManage showvminfo win | grep "Number of" | tr -s ' ' | cut -d' ' -f4`
echo "Numero de CPUs:" $numero_de_CPUs

#Se obtiene el tamaño de la memoria RAM de la maquina virtual y se imprime por pantalla.
size_RAM=`VBoxManage showvminfo win | grep Memory | tr -s ' ' | cut -d' ' -f3`
echo "Tamaño de RAM:" $size_RAM

#Se obtiene el numero de interfaces de red de la maquina virtual y se imprime por pantalla.
num_interfacesRed=`VBoxManage showvminfo win | grep Attachment  | tr -s ' '| tr -d : | cut -d' ' -f2`
echo "Numero de Interfaces de Red: " $num_interfacesRed

#Se obtiene el tipo de las interfaces de red de la maquina virtual y se imprime por pantalla.
tipo=`VBoxManage showvminfo win | grep Attachment  | tr -s ' '| tr -d , | cut -d' ' -f6`
echo "Tipo:" $tipo

