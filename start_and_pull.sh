#!/bin/bash

app_name="portfolio"
image_name="ghcr.io/phitiet/portfolio:latest"

stop_container() {
    docker stop $app_name >/dev/null 2>&1 || true
}

deploy_container() {
    docker rm $app_name >/dev/null 2>&1 || true
    docker run -d --name $app_name -p 8080:8080 $image_name > output.log 2>&1 &
    echo "$app_name application started successfully"
}

pull_output=$(docker pull --platform arm64 $image_name 2>&1)

if [[ $pull_output == *"Downloaded newer image"* ]]; then
    stop_container
    deploy_container
elif [[ $pull_output == *"Image is up to date"* ]]; then
    echo "Image is up-to-date"
    if ! docker ps | grep -q $app_name; then
        deploy_container
    fi
else
    echo "Failed to pull the latest image."
    echo "$pull_output"
    exit 1
fi
