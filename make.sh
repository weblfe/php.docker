#!/usr/bin/env bash

name="$1"
user="weblinuxgame"

# tag
if [[ "$name" == "" ]];then
   echo "please input docker tag name!"
   echo "make.sh <tag> <dockerfile.ext> <tag.version>"
   echo "eg: make.sh php7.4-fpm-amqp  php7.4 v0.1.0"
   exit 1
fi
# dockerfile
if [[ "$2" == "" ]];then
  dockerFile="Dockerfile"
else
  dockerFile="Dockerfile.$2"
fi
# version
if [[ "$3" != "" ]];then
  name="$name:$3"
fi

#  make.sh <tag> <dockerfile.ext> <tag.version>
#  eg: make.sh php7.4-fpm-amqp  php7.4 v0.1.0
echo "docker build -t $user/${name} -f ${dockerFile} ."
docker build -t $user/${name} -f ${dockerFile} .
