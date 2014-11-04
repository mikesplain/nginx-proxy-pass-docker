# Nginx Proxy Pass

A simple container that proxy passes to an external source.

A number of great containers for reverse proxying to containers exist however I couldn't find any that would proxy pass to external sources on the fly.

Simply run:

```
docker run -d -p 80:80 -e TARGET_SERVER=<proxy location> mikesplain/nginx-proxy-pass
```

For example, want to proxy everything to google? WHY NOT?!
```
docker run -d -p 80:80 -e TARGET_SERVER=google.com mikesplain/nginx-proxy-pass
```

Or maybe another server on your network:
```
docker run -d -p 80:80 -e TARGET_SERVER=192.168.8.15:8080 mikesplain/nginx-proxy-pass
```
