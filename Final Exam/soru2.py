# Burak Cakan - 702201003 - 25/01/2021
import sys
import os 
import subprocess
import numpy as np
from subprocess import PIPE, Popen
from pprint import pprint as pp
import math

def cmdline(command):
    process = Popen(
        args=command,
        stdout=PIPE,
        shell=True
    )
    return process.communicate()[0].decode("UTF-8")

addressList = []

addressList = cmdline("find . -name '*.xyz'").split() #all file names, ends with .xyz, are stored here 

addressList.remove("./old.xyz")

inputs = {} 

for i in range(len(addressList)):

	filename=addressList[i].lstrip("./")
	sdf_file=open(filename,"r") 

	inputs[i] = [] 

	data = sdf_file.readlines()

	x = []
	y = []
	z = []

	for j, line in enumerate(data): 
		if j>=2: 
			data[i] = data[j].rstrip('\n')
			x.append(float(data[j].split()[1]))
			y.append(float(data[j].split()[2]))
			z.append(float(data[j].split()[3]))

	inputs[i].append(x)
	inputs[i].append(y)
	inputs[i].append(z)

distances = {}

for i in range(len(inputs)):

	dist = []

	for j in range(len(inputs[i][0])):

		dist_temp = []

		for k in range(len(inputs[i][0])):

			d = math.sqrt((inputs[i][0][j] - inputs[i][0][k])**2 + (inputs[i][1][j] - inputs[i][1][k])**2 + (inputs[i][2][j] - inputs[i][2][k])**2)

			dist_temp.append(d)

		dist.append(dist_temp)

	distances[i] = dist

is_similar = np.zeros([len(inputs),len(inputs)])


aaa = []

for i in range(len(inputs)):

	for j in range(len(inputs)):

		not_similar = 0

		for k in range(20):

			for m in range(20):

				aaa.append(abs(distances[i][k][m] - distances[j][k][m]))

				if abs(distances[i][k][m] - distances[j][k][m]) > 0.01:

					not_similar = 1
					break

			if not_similar == 1:
				break

		if not_similar != 1:		
			is_similar[i][j] = 1

pp(is_similar)

for i in range(len(inputs)):
	for j in range(len(inputs)):
		if is_similar[i][j]==1:
			print(str(addressList[i].lstrip('./'))+' is similar to '+str(addressList[j].lstrip('./')))
			#print('\n')


#is_similar matrixini kontrol etmek icin asagidakileri bastirdim:
#print(distances[0][12][6])
#print(distances[1][12][6])
#print(distances[2][12][6])
#print(distances[3][12][6])






