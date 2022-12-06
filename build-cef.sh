#!/bin/bash

mkdir -p build-artifacts
docker build -t cef-build .
docker run -v $(pwd)/build-artifacts/:/usr/build/code/build-artifacts -v $(pwd)/scripts:/usr/build/code/scripts cef-build:latest
ls -lart build-artifacts
