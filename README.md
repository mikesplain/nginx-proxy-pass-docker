# Nginx Proxy Pass

A simple container that proxy passes to an external source.

A number of great containers for reverse proxying to containers exist(I'm a fan of jwilder/nginx-proxy) however I couldn't find any that would proxy pass to external sources on the fly.

Simply run:

```
docker run -d -p 80:80 -e TARGET=<proxy location> ssuareza/nginx-proxy-pass
```

For example, want to proxy everything to google? WHY NOT?!

```
docker run -d -p 80:80 -e TARGET=https://google.com ssuareza/nginx-proxy-pass
```

Or maybe another server on your network:

```
docker run -d -p 80:80 -e TARGET=http://192.168.8.15:8080 ssuareza/nginx-proxy-pass
```

## Use authentication

Just mount a htpassword file. Example:

```sh
docker run -d -p 80:80 \
  -v .htpasswd:/etc/nginx/.htpasswd
  -e TARGET=<proxy location> \
  ssuareza/nginx-proxy-pass
```

To create a htpassword run:

```sh
htpasswd -c .htpasswd user1
```
