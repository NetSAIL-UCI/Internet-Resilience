import json
import os

entries = os.listdir('../datasets/submarine-map/public/api/v2/cable/')

for entry in entries:
    filename = '../datasets/submarine-map/public/api/v2/cable/' + entry
    if (filename != "../datasets/submarine-map/public/api/v2/cable/all.json" and
            filename != "../datasets/submarine-map/public/api/v2/cable/cable-geo.json"):
        with open(filename) as f:
            data = json.load(f)
            cableId = data["cable_id"]
            cableLength = data["length"]
            if (cableLength != "n.a."):
                size = len(cableLength)
                cableLength = cableLength[:size - 3] # remove " km" at the end of the string
                cableLength2 = cableLength.replace(',', '') 
                print ('{} {} {} {} {}'.format(cableId, cableLength2, int(float(cableLength2)/50), int(float(cableLength2)/100), int(float(cableLength2)/150)))
