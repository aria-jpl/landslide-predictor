#!/bin/bash

set -e

name=landslide-predictor
context=.

#    --no-cache \
docker build ${context} \
    --file ${context}/docker/Dockerfile \
    --tag hysds/${name}:20200928
