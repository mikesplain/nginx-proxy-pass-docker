#!/bin/sh

HOST_SERVER=${HOST_SERVER:-\$host}

/bin/sed -i "s/<target_server>/${TARGET_SERVER}/" /etc/nginx/conf.d/default.conf
/bin/sed -i "s/<target_protocol>/${TARGET_PROTOCOL}/" /etc/nginx/conf.d/default.conf

nginx -g "daemon off;"
