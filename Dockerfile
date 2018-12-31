FROM nginx:1.10.1-alpine

# Default http protocol
ENV HTTP_PROTOCOL=http \
    FILTER_PATH=0

COPY default.conf /etc/nginx/conf.d/default.conf

ADD start.sh /start.sh
RUN chmod 700 /start.sh

EXPOSE 80

CMD ["./start.sh"]
