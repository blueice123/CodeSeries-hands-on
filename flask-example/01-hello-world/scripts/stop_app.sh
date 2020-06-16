#!/bin/bash

isExistApp=`ps -ef|grep python| grep -v grep`
if [[ -n  $isExistApp ]]; then
    sudo kill -9 $(ps -ef |grep hello.py |grep -v grep | awk '{print $2}')
fi