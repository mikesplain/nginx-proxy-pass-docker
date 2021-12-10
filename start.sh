#!/bin/sh

CONFIG=/etc/nginx/conf.d/default.conf
PROTOCOL=$(echo $TARGET |cut -f1 -d:)
SERVER=$(echo $TARGET |sed -e 's/http[?s]:\/\/\(.*\)/\1/g')

/bin/sed -i "s/<target_server>/${SERVER}/" $CONFIG
/bin/sed -i "s/<target_protocol>/${PROTOCOL}/" $CONFIG

if [ ! -f "/etc/nginx/.htpasswd" ];then
  /bin/sed -i "/auth_basic*/d" $CONFIG
fi

cat $CONFIG

nginx -g "daemon off;"
