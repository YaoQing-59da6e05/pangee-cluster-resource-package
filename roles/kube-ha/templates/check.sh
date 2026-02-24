#!/bin/bash
count=`netstat -ntl | grep {{ kube_apiserver_vip_port }} | wc -l`
if [ $count -gt 0 ]; then
    exit 0
else
    exit 1
fi
