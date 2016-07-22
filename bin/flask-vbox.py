#!/usr/bin/python
# -*- coding: iso-8859-15 -*-

#Desarrollo de un conjunto de web services que permite realizar operaciones básicas sobre las máquinas virtuales. 

# Librerias requeridas para correr aplicaciones basadas en Flask
from flask import Flask, jsonify, make_response,request
import subprocess

app = Flask(__name__)


#1) Este metodo retorna la lista de sistemas operativos soportados por VirtualBox al acceder al web service desde la linea de comandos
#usando el comando curl mas el URL: curl http://localhost:5000/vms/ostypes

# Solucion del item 1.
@app.route('/vms/ostypes',methods = ['GET'])
def ostypes():
	output = subprocess.check_output(['VBoxManage', 'list', 'ostypes'])
	return output

# 2.1)Este metodo retorna la lista de maquinas asociadas con un usuario al acceder al web service desde la linea de comandos
#usando el comando curl mas el URL: curl http://localhost:5000/vms

# Solucion del item 2a.
@app.route('/vms',methods = ['GET'])
def listvms():
	output = subprocess.check_output(['VBoxManage', 'list', 'vms'])
	return output

# 2.2) Este metodo retorna aquellas maquinas que se encuentran en ejecucion al acceder al web service desde la linea de comandos
#usando el comando curl mas el URL: curl http://localhost:5000/vms/runnings
# Este es el codigo del item 2b

# Solucion del item 2b.
@app.route('/vms/running',methods = ['GET'])
def runninglistvms():
	output = subprocess.check_output(['VBoxManage', 'list', 'runningvms'])
	return output

# 3.3)Este metodo retorna las caracteristicas de una maquina virtual cuyo nombre se pasara como parametro en las variable vmname 

@app.route('/vms/info/<vmname>', methods = ['GET'])
def vminfo(vmname):
	output = subprocess.check_output(['./caracteristas_vbx.sh',vmname])
	return output

#4)Este metodo crea una maquina virtual usando el método POST del protocolo HTTP.

@app.route('/vms/crear', methods=['POST'])
def crear():
 nombre= request.json['nombre']
 tamRam= request.json['tamRam']
 nucleos=request.json['nucleos']
 output = subprocess.check_output(['./maquinaVirtual.sh',nombre,tamRam,nucleos])
 return output


# - El item 5 deberá usar el método DELETE del protocolo HTTP
@app.route('/vms/borrar/<vmname>', methods = ['DELETE'])
def borrar(vmname):
	output = subprocess.check_output(['./borrar.sh',vmname])
	
	return output

if __name__ == '__main__':
   app.run(debug = True, host='0.0.0.0')
