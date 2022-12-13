#!/bin/bash

mkdir -p build-artifacts
docker build -t cef-build .
docker run -v $(pwd)/build-artifacts/:/usr/build/code/build-artifacts cef-build:latest
ls -ll build-artifacts
