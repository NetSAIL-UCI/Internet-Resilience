import json
import os

filename = '../datasets/submarine-map/public/api/v2/landing-point/all.json'
with open(filename) as f:
    data = json.load(f)
    for item in data:
        print ('{} {} {} {}'.format(item["city_id"], float(item["latitude"]), float(item["longitude"]), str(item["id"])))
    
