#!/usr/bin/env sh

aem_stop() {
    /usr/local/bin/aem instance -A stop
    exit 0
}

trap aem_stop INT TERM

/usr/local/bin/aem instance -A start

tail -F /opt/aem/home/var/instance/author/crx-quickstart/logs/error.log
