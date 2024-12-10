#!/usr/bin/env sh

aem_stop() {
    /usr/local/bin/aem instance --instance-${RUNMODE} stop
    exit 0
}

trap aem_stop INT TERM EXIT

ln -sf /proc/1/fd/1 /opt/aem/home/var/instance/${RUNMODE}/crx-quickstart/logs/error.log

/usr/local/bin/aem instance --instance-${RUNMODE} start

(cat)