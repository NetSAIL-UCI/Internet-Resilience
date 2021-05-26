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

level1 = sys.argv[1]
level2 = sys.argv[2]
level3 = sys.argv[3]

filePrefix = "../processedData/intertubes/intertubes-nonUniform-" + level1 + "-" + level2 + "-" + level3

processNodeAndLinkFailures(nodeToCablesDict, cableToLevelDict, cabRepCount, filePrefix, float(level1), float(level2), float(level3))


