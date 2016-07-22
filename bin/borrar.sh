#!/bin/bash

#Desasociamos el disco duro de la máquina virtual :
VBoxManage modifyvm $1 --hda none

#Borramos la máquina de VirtualBox:
VBoxManage unregistervm $1 -delete
