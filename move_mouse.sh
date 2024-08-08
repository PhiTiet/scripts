#!/bin/bash

while true; do
    c=$(cliclick p)
    IFS=',' read -r c_x c_y <<< "$c"
    n_x=$((c_x - 1))
    cliclick "m:$n_x,$c_y"
    sleep 300
done
