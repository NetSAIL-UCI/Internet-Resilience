import yaml
import os

entries = os.listdir('../datasets/dns/')

wrFilename = '../processedData/dns-list.txt'
locations = 0
with open(wrFilename, 'w') as wrF:
    for entry in entries:
        filename = '../datasets/dns/' + entry
        with open(filename) as f:
            data = yaml.safe_load(f)
            name = entry.split("-")
            #print (entry)
            for item in data["Instances"]:
                if ("Latitude" in item):
                    wrF.write('{} {} {} {}\n'.format(item["Latitude"], item["Longitude"], name[0], item["Town"]))
                    locations = locations + 1
wrF.close()

for lat in range(0,91):
    instCount = 0
    with open(wrFilename) as f:
        for cnt, line in enumerate(f):
            vals = line.split()
            if (abs(float(vals[0])) >= lat):
                instCount = instCount + 1
    print (lat, instCount, instCount * 1.0 / locations)
