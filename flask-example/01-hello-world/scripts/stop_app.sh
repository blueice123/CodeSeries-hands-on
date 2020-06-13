#!/bin/bash

isExistApp=`pgrep hello.py`
if [[ -n  $isExistApp ]]; then
    sudo kill -9 $(ps -ef |grep hello.py |grep -v grep | awk '{print $2}')
fi