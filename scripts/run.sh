#!/bin/bash

# Copy graph files
cp -r /mnt/efs/graphhopper /mnt/cache

# Run jar
java -Xmx10G -D'dw.graphhopper.datareader.file=/var/graphhopper/data/graphhopper.osm.pbf' -jar /var/graphhopper/graphhopper-web-9.1.jar server config.yml