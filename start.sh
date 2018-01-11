#!/bin/sh
/bin/sed -i "s/<proxy_pass_protocol_placeholder>/${HTTP_PROTOCOL}/" /etc/nginx/sites-enabled/default
/bin/sed -i "s/<proxy_pass_placeholder>/${TARGET_SERVER}/" /etc/nginx/sites-enabled/default

nginx -g "daemon off;"
