# Graphhopper deployment in AWS

This is a sample repository for a deployment of GraphHopper in AWS via their Elastic Container Service. I'm writing a short article explaining the deployment further which I'll link here in due time.

## What is Graphhopper?

GraphHopper is one of the best routing engines out there, it supports route planning, isochrone analysis, geocoding and route optimisation. It's very powerful and you can host your own version of the application itself!

https://www.graphhopper.com/

## Basic Deployment

1. Clone the repo and add your own GTFS files to the data folder, update the Dockerfile to use your own osm export file.
2. Create an ECS cluster and EFS, make sure to use EC2s with an SSD
3. Create a CodePipeline project with a build step which runs the scripts/build.sh
4. Create an ECS for GraphHopper which runs a task definition making use of the ECR deployed by CodePipeline