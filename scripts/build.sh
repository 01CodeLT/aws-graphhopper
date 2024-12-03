# Check if data changed
VERSION_DIFF="$(cmp --silent -- "${CODEBUILD_SRC_DIR}/data/version.txt" "/mnt/efs/graphhopper/version.txt"; echo $?)"
if [ $VERSION_DIFF -ne 0 ]; then
    # Install Java
    echo "Installing Java..."
    apt-get update; apt-get install -y java-21-amazon-corretto-jdk
    update-alternatives --auto javac
    update-alternatives --auto java

    # Create fake cache dir
    mkdir /mnt/cache

    # Remove existing
    echo "Removing existing data from EFS..."
    rm -r -f /mnt/efs/*

    # Get graphopper
    echo "Downloading graphhopper jar..."
    wget https://repo1.maven.org/maven2/com/graphhopper/graphhopper-web/9.1/graphhopper-web-9.1.jar 

    # Download pbf
    wget https://your-s3-location -O data/graphhopper.osm.pbf

    # Import data
    echo "Importing data via graphhopper..."
    java -Xmx10G -D'dw.graphhopper.datareader.file=data/graphhopper.osm.pbf' -jar graphhopper-web-9.1.jar import config.yml

    # Create dirs, copy files, change permissions
    echo "Changing permissions and copying files..."
    cp -r /mnt/cache/graphhopper /mnt/efs
    chmod -R 777 /mnt/efs/graphhopper

    # Copy version
    cp "${CODEBUILD_SRC_DIR}/data/version.txt" /mnt/efs/graphhopper/version.txt

    # Remove cache
    rm -r /mnt/cache
fi

echo "Import completed successfully"