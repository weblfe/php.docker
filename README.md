# php docker 工具包

> 工具包含概： php5.6 ~ php8

Linux 基础镜像为 alpine(3.13-3.14)

```shell 
1. Dockerfile : php:5.6 + apache 
2. Dockerfile.v2 : php5.6 (amqp + redis + mysql) 
3. Dockerfile.php7 : php7.3.30-fpm ( amqp +protobuf + redis + mysql + imagick + gd + mcrypt)
4. Dockerfile.php7.4 : php7.4.23-fpm ( amqp +protobuf + redis + mysql + mongodb + imagick + gd + mcrypt)
5. Dockerfile.php8 : php8.0.10-fpm ( amqp +protobuf + redis + mysql + mongodb + imagick + gd + mcrypt)
6. Dockerfile.worker :php7.4-v3.14-fpm ( swoole + redis + mysql )
```

# 镜像制作 脚本

make.sh

```shell
./make.sh  php7.4-fpm-amqp  php7.4 v0.1.0
```

[本人dockerhub 地址](https://hub.docker.com/u/weblinuxgame)