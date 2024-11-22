#!/usr/bin/env sh

aem_stop() {
    /usr/local/bin/aem instance --instance-${RUNMODE} stop
    exit 0
}

trap aem_stop INT TERM

/usr/local/bin/aem instance --instance-${RUNMODE} start

tail -F /opt/aem/home/var/instance/${RUNMODE}/crx-quickstart/logs/error.log
