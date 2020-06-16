#!/bin/bash

isExistApp=`ps -ef|grep hello.py| grep -v grep`
if [[ -n  $isExistApp ]]; then
    echo "0"
else
    echo "1"
fi