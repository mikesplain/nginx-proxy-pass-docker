#!/bin/sh

HOST_SERVER=${HOST_SERVER:-\$host}

# Extract the protocol (includes trailing "://").
PARSED_PROTO="$(echo $TARGET_SERVER | sed -nr 's,^(.*://).*,\1,p')"
# Remove the protocol from the URL.
PARSED_URL="$(echo ${TARGET_SERVER/$PARSED_PROTO/})"
# Extract the user (includes trailing "@").
PARSED_USER="$(echo $PARSED_URL | sed -nr 's,^(.*@).*,\1,p')"
# Remove the user from the URL.
PARSED_URL="$(echo ${PARSED_URL/$PARSED_USER/})"
# Extract the port (includes leading ":").
PARSED_PORT="$(echo $PARSED_URL | sed -nr 's,.*(:[0-9]+).*,\1,p')"
# Remove the port from the URL.
PARSED_URL="$(echo ${PARSED_URL/$PARSED_PORT/})"
# Extract the path (includes leading "/" or ":").
PARSED_PATH="$(echo $PARSED_URL | sed -nr 's,[^/:]*([/:].*),\1,p')"
# Remove the path from the URL.
PARSED_HOST="$(echo ${PARSED_URL/$PARSED_PATH/})"

# define the default config file once.
CONF_FILE="/etc/nginx/conf.d/default.conf"

# perform the substitution.
if [ ! -z ${PARSED_PATH} ] && [ ${FILTER_PATH} -eq 1 ]; then
  /bin/sed -i "s,<filter_block>,sub_filter\t${PARSED_PATH} /;\n    sub_filter_types\t*;\n    sub_filter_once\toff;," ${CONF_FILE}
else
  /bin/sed -i "s,<filter_block>,," ${CONF_FILE}
fi;
/bin/sed -i "s,<proxy_pass_protocol_placeholder>,${HTTP_PROTOCOL}," ${CONF_FILE}
/bin/sed -i "s,<proxy_pass_placeholder>,${TARGET_SERVER}," ${CONF_FILE}
/bin/sed -i "s,<host_placeholder>,${HOST_SERVER}," ${CONF_FILE}

nginx -g "daemon off;"
