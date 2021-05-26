import json
import os
import sys
import random
import numpy

from processRepeaterFailures import processNodeAndLinkFailures

cableToNodesDict = {}
nodeToCablesDict = {}

for node in range(1, 274):
    nodeToCablesDict[node] = []

nodeDict = {}
filename = '../datasets/intertubes/intertubes-nodes-latlong.txt'
with open(filename) as f:
    for cnt, line in enumerate(f):
        vals = line.split()
        nodeDict[int(vals[0])] = [float(vals[1]), float(vals[2])]

cabRepCount = {}
cableToLevelDict = {}
filename = "../processedData/intertubes-repeaters.txt"
with open(filename) as f:
    linkCount = 0
    for cnt, line in enumerate(f):
        vals = line.split()
        node1 = int(vals[0])
        node2 = int(vals[1])
        level = 3
        if (abs(nodeDict[node1][0]) >= 60 or abs(nodeDict[node2][0]) >= 60):
            level = 1
        elif ((abs(nodeDict[node1][0]) >= 40 and abs(nodeDict[node1][0]) < 60) or ((abs(nodeDict[node2][0]) >= 40 and abs(nodeDict[node2][0]) < 60))):
            level = 2
        cabRepCount[linkCount] = (int(vals[3]), int(vals[4]), int(vals[5]), level)
        cableToLevelDict[linkCount] = level
        #print (cabRepCount[linkCount], abs(nodeDict[node1][0]), abs(nodeDict[node2][0]))
        nodeToCablesDict[int(vals[1])].append(linkCount)
        nodeToCablesDict[int(vals[0])].append(linkCount)
        linkCount = linkCount + 1

filePrefix = "../processedData/intertubes/intertubes-uniform"

probList = [0.001, 0.002, 0.003, 0.004, 0.005, 0.006, 0.007, 0.008, 0.009, 0.01, 0.02, 0.03, 0.04, 0.05, 0.06, 0.07, 0.08, 0.09, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0]

for prob in probList:
    processNodeAndLinkFailures(nodeToCablesDict, cableToLevelDict, cabRepCount, filePrefix, prob, prob, prob)
