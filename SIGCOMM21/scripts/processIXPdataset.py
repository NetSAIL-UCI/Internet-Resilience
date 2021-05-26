import json
import os

filename = '../datasets/IXPs/ixp-data-all.json'
with open(filename) as f:
    data = json.load(f)
    for item in data:
        if (item["lat"] and item["lon"]):
            print ('{} {} {}'.format(item["id"], item["lat"], item["lon"]))
    
