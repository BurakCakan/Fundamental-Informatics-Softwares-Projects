# Burak Cakan - 702201003 - 23/01/2021
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

inputs = {} #this dictionary stores list for every file

for i in range(len(addressList)):

	filename=addressList[i].lstrip("./")
	sdf_file=open(filename,"r") # opens every file one by one 
	inputs[i] = [] 
	inputs[i].append(sdf_file.readline().rstrip("\n")) # keeps the number of atoms for ith file 
	a = sdf_file.readline().split() # keeps energy and cell parameters for ith file in a different variable to clean it

	s = 0
	p = 0

	for j in range(len(a)): #this loop is for cleanin the second line from some string values like energy, cell parameters

		if a[j] == "Energy=":
			s = j+1
			continue
		if a[j] == "Parameters:":
			p = j+1
			continue

		if j == s:
			inputs[i].append(float(a[j]))
		if j == p:
			par = []
			for k in range(p,len(a)):
				par.append(float(a[k]))
			inputs[i].append(par)

	sdf_file.close() #file is closed here

def volume(x): # 1st function in the hw

	m = np.reshape(x,(3,3))
	vol = abs(np.linalg.det(np.array(m)))
	return vol


def find_center(file): #2nd function in the hw
	sdf_file=open(file,"r")
	data = sdf_file.readlines() # reads all data 
	x = []
	y = []
	z = []

	for i, line in enumerate(data): 
		if i>=2: # this statment is for storing the data from 3rd line
			data[i] = data[i].rstrip('\n')
			x.append(float(data[i].split()[1]))
			y.append(float(data[i].split()[2]))
			z.append(float(data[i].split()[3]))

	x_center = 0
	for i in range(len(x)):
		x_center += x[i]
	x_center /= len(x)

	y_center = 0
	for i in range(len(y)):
		y_center += y[i]
	y_center /= len(y)

	z_center = 0
	for i in range(len(z)):
		z_center += z[i]
	z_center /= len(z)

	center = [x_center, y_center, z_center]
	return center

def dist(cent1,cent2): #to calculate distance btw two centers
	d = 0
	for i in range(len(cent1)): #this is euclidean distance
		d += (cent1[i]-cent2[i])**2
	r = math.sqrt(d)
	return r

def center_dist(file1,file2): 
	cent1 = find_center(file1)
	cent2 = find_center(file2)
	r = dist(cent1,cent2)
	return r


#print(volume(inputs[0][2])) #used to try 1st function
#pp(find_center("LiSc44_475.xyz")) #used to try 2nd function
#pp(center_dist("LiSc44_475.xyz","LiSc44_475.xyz")) #used to try 3rd function

energy_val = []
for i in range(len(inputs)):
	energy_val.append(inputs[i][1])
ind = sorted(range(len(inputs)), key = lambda k: energy_val[k]) #used for sorting energy values 

report = []
for i in range(len(inputs)):
	line = []
	line.append(addressList[ind[i]].lstrip("./").rstrip(".xyz"))
	line.append(inputs[ind[i]][0])
	line.append(inputs[ind[i]][1])
	line.append(volume(inputs[ind[i]][2]))
	report.append(line)

#statements below are for preparing the intended output: 
print( "Yapi Adi" + " "*(25-len("Yapi Adi")) 
		+ "Atom Sayisi" + " "*(15-len("Atom Sayisi")) 
		   + "Enerji" +" "*(15-len("Enerji")) 
		   + "Cell Hacmi"
	)
for i in range(len(report)):
	print( report[i][0] + " "*(25-len(report[i][0])) 
		   + str(report[i][1]) + " "*(15-len(str(report[i][1]))) 
		   + str(report[i][2]) +" "*(15-len(str(report[i][2]))) 
		   +str(report[i][3]))


#print(line[0]+" "*(25-len(line[0]))+"a") #used to try this statement