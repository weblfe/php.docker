#!/bin/bash

if [ ! -e /data/wwwroot/worker ];then
   mkdir -p /data/wwwroot/worker/worker
fi

cd /data/wwwroot/worker/worker

if [ "${1}x" = "x" ];then
  #composer dump
  php bin/hyperf.php start >./runtime/logs/run.log 2>&1
else
  "${1}"
fi
