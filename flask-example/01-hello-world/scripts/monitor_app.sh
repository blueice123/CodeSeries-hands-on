#!/bin/bash

isExistApp=`pgrep hello.py`
if [[ -n  $isExistApp ]]; then
    echo "0"
elif echo "1"
fi