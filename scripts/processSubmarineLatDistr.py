import json
import os

neighborDict = {}
latLonDict = {}
filename = '../processedData/submarine-landingPts.txt'
with open(filename) as f:
    for cnt, line in enumerate(f):
        vals = line.split()
        neighborDict[int(vals[0])] = []
        latLonDict[int(vals[0])] = (float(vals[1]), float(vals[2]))

entries = os.listdir('../datasets/submarine-map/public/api/v2/cable/')

for entry in entries:
    filename = '../datasets/submarine-map/public/api/v2/cable/' + entry
    if (filename != "../datasets/submarine-map/public/api/v2/cable/all.json" and 
            filename != "../datasets/submarine-map/public/api/v2/cable/cable-geo.json"):
        with open(filename) as f:
            data = json.load(f)
            nodeList = []
            for item in data["landing_points"]:
                latLong = item["latlon"].split(",")
                nodeList.append((int(item["landing_point_id"])))
            for node1 in nodeList:
                for node2 in nodeList:
                    if node1 != node2 and node2 not in neighborDict[node1]:
                        neighborDict[node1].append(node2)


for lat in range(0,91):
    nodeCheck = {}
    absCheck = {}
    for key in neighborDict:
        nodeCheck[key] = 0
        absCheck[key] = 0
        if (abs(latLonDict[key][0]) >= lat):
            nodeCheck[key] = 1
            absCheck[key] = 1
            continue
        for neighbor in neighborDict[key]:
            if (abs(latLonDict[neighbor][0]) >= lat):
                nodeCheck[key] = 1
                continue
    nodeCount = 0
    nodeCount2 = 0
    for key in nodeCheck:
        if nodeCheck[key] == 1:
            nodeCount = nodeCount + 1
        if absCheck[key] == 1:
            nodeCount2 = nodeCount2 + 1
    print (lat, nodeCount, nodeCount*100/1241.0, nodeCount2, nodeCount2*100/1241.0)
