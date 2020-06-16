#!/bin/bash

isExistApp=`ps -ef|grep python| grep -v grep`
if [[ -n  $isExistApp ]]; then
    echo "0"
else
    echo "1"
fi