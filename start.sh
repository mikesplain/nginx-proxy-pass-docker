#!/bin/sh
/bin/sed -i "s/<proxy_pass_placeholder>/${TARGET_SERVER}/" /etc/nginx/conf.d/default.conf

nginx -g "daemon off;"
