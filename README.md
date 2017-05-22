# Apache Traffic Server Docker images

This repository contains Docker images for
[Apache Traffic Server](https://trafficserver.apache.org/).  The images are
published to https://hub.docker.com/r/torchbox/trafficserver.

## Using the images

Traffic Server is installed in `/usr/local`, and the image's `CMD` is set to
`traffic_cop`, which is a reasonable default.

Configuration is in `/usr/local/etc/trafficserver/`.  You can either build your
own image to replace the default configuration, or mount an external volume
there (or configure it some other way, such as with Kubernetes ConfigMaps).

Cache storage is in `/var/lib/trafficserver`.  You should mount persistent
storage here if you expect the cache to persist across restarts.

Logs are in `/var/log/trafficserver`.  Logs are rotated by default but there is
no log collecting; in particular, access and error logs are not written to
`stdout`.

## Available version and tags

* Traffic Server 7.0.x: `torchbox/trafficserver:7.0.0-1.0`
    * Release history:
        * 7.0.0-1.0: Initial release.

