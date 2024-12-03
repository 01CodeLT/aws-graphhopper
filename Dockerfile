FROM amazoncorretto:17-alpine-jdk

# Add files
WORKDIR /var/graphhopper
ADD data data/
RUN wget https://your-s3-location -O data/graphhopper.osm.pbf -O data/graphhopper.osm.pbf

# Copy files
ADD config.yml ./
ADD scripts/run.sh ./scripts/run.sh
RUN chmod +x ./scripts/run.sh

# Download jar
RUN wget https://repo1.maven.org/maven2/com/graphhopper/graphhopper-web/9.1/graphhopper-web-9.1.jar 

EXPOSE 8080

CMD ["sh", "./scripts/run.sh"]