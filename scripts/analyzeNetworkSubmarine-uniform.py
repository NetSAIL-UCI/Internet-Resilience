import json
import os
import sys
import random
import numpy
from processRepeaterFailures import processNodeAndLinkFailures

cableToNodesDict = {}
nodeToCablesDict = {}
cableToLevelDict = {}
latLonDict = {}


filename = '../processedData/submarine-landingPts.txt'
with open(filename) as f:
    for cnt, line in enumerate(f):
        vals = line.split()
        nodeToCablesDict[int(vals[0])] = []
        latLonDict[int(vals[0])] = (float(vals[1]), float(vals[2]))

entries = os.listdir('../datasets/submarine-map/public/api/v2/cable/')
for entry in entries:
    filename = '../datasets/submarine-map/public/api/v2/cable/' + entry
    if (filename != "../datasets/submarine-map/public/api/v2/cable/all.json" and
            filename != "../datasets/submarine-map/public/api/v2/cable/cable-geo.json"):
        with open(filename) as f:
            data = json.load(f)
            nodeList = []
            level = 3
            highestLat = 0.0
            for item in data["landing_points"]:
                nodeList.append((int(item["landing_point_id"])))
                if (abs(latLonDict[int(item["landing_point_id"])][0]) > highestLat):
                    highestLat = abs(latLonDict[int(item["landing_point_id"])][0])
                nodeToCablesDict[int(item["landing_point_id"])].append(int(data["cable_id"]))
            cableToNodesDict[int(data["cable_id"])] = nodeList
            if (highestLat >= 60):
                level = 1
            elif (highestLat >= 40 and highestLat < 60):
                level = 2
            cableToLevelDict[int(data["cable_id"])] = level

cabRepCount = {}
filename = "../processedData/submarine-cable-repeaters.txt"
with open(filename) as f:
    for cnt, line in enumerate(f):
        vals = line.split()
        cabRepCount[int(vals[0])] = (int(vals[2]), int(vals[3]), int(vals[4]))


filePrefix = "../processedData/submarineCables/submarine-uniform"

probList = [0.001, 0.002, 0.003, 0.004, 0.005, 0.006, 0.007, 0.008, 0.009, 0.01, 0.02, 0.03, 0.04, 0.05, 0.06, 0.07, 0.08, 0.09, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0]

for prob in probList: 
    processNodeAndLinkFailures(nodeToCablesDict, cableToLevelDict, cabRepCount, filePrefix, prob, prob, prob)
    
    
    
    
    
    
    
    
    
