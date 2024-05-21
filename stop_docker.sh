#!/bin/bash

app_name="portfolio"

if docker ps | grep -q $app_name; then
    docker stop $app_name >/dev/null 2>&1
    echo "$app_name stopped successfully."
else
    echo "No containers running with name: $app_name"
fi
