#!/bin/bash
#
# Este archivo ejecuta una serie de comandos en bash para crear maquinas virtuales en VirtualBox.
#
#Creacion del disco virtual dinamico para la maquina
VBoxManage createhd --filename $1.vdi --size 10000

#Creacion de la maquina con su respectivo ostype
VBoxManage createvm --name $1 --ostype "Ubuntu" --register

#Creacion del controlador para el disco
VBoxManage storagectl $1 --name "SATA Controller" --add sata --controller IntelAHCI

# Se vincula el disco duro virtual al controlador
VBoxManage storageattach $1 --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium $1.vdi

#Creacion del controlador para dispositivos de almacenamiento
VBoxManage storagectl $1 --name "IDE Controller" --add ide

#Se vincula el iso al controlador VBoxManage storageattach $VM --storagectl "IDE Controller" --port 0 --device 0 --type dvddrive --medium /tmp/ubuntu-server32.iso

VBoxManage modifyvm $1 --ioapic on
VBoxManage modifyvm $1 --boot1 dvd --boot2 disk --boot3 none --boot4 none

#Asigna un tamaño de memoria RAM
VBoxManage modifyvm $1 --memory $2 --vram 128

#Asigna un numero de nucleos para CPUs de la maquina virtual
VBoxManage modifyvm $1 --cpus $3

#Configura la tarjeta de red de la memoria virtual
VBoxManage modifyvm $1 --nic1 bridged --bridgeadapter1 e1000g0
