#!/bin/bash

rm pangee-cluster-1.28.15_v1.zip 2>> /dev/null
zip -r pangee-cluster-1.28.15_v1.zip . -x "*.git/*" "*.github/*" "cache/*" "temp/*"