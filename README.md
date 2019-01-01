# Nginx Proxy Pass

A simple container that proxy passes to an external source.

A number of great containers for reverse proxying to containers exist (I'm a fan of [jwilder/nginx-proxy](https://github.com/jwilder/nginx-proxy)) however I couldn't find any that would proxy pass to external sources on the fly.

Simply run:

```bash
docker run -d -p 80:80 -e HTTP_PROTOCOL=<protocol> -e TARGET_SERVER=<proxy location> guysoft/nginx-proxy-pass
```

For example, want to proxy everything to google? WHY NOT?!

```bash
docker run -d -p 80:80 -e HTTP_PROTOCOL=https -e TARGET_SERVER=google.com guysoft/nginx-proxy-pass
```

Or maybe another server on your network:

```bash
docker run -d -p 80:80 -e HTTP_PROTOCOL=http -e TARGET_SERVER=192.168.8.15:8080 guysoft/nginx-proxy-pass
```

## Using paths

In certain instances, you may wish to reverse proxy into a subfolder of the target server. You can do this by passing a path in the target server:

```bash
docker run -d -p 80:80 -e HTTP_PROTOCOL=http -e TARGET_SERVER=192.168.8.15:8080/path guysoft/nginx-proxy-pass
```

### Filtering

Sometimes, the scripts in the target server are hardcoded to the specific path. In order to correct this, you can use the ```FILTER_PATH``` environment variable:

```bash
docker run -d -p 80:80 -e HTTP_PROTOCOL=http -e TARGET_SERVER=192.168.8.15:8080/path -e FILTER_PATH=1 guysoft/nginx-proxy-pass
```

This will re-write the URLs in the response, allowing your reverse proxy to work as desired. However, this should only be done in instances where the path is hardcoded in the target script files.