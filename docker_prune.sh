#!/bin/bash
exec > /home/pi/scripts/dockerprune/output.log 2>&1

docker system prune -a -f
