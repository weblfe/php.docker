#!/usr/bin/env sh
cat >/etc/motd <<EOL
A P P   S E R V I C E   O N   L I N U X
AMQP 1.9.0
PHP version : ${PHP_VERSION}
EOL
cat /etc/motd
# Get environment variables to show up in SSH session
echo "start queue server..."
/usr/local/bin/php /home/site/wwwroot/bongolive/public/queue/queue.php

