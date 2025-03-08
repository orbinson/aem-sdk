#!/usr/bin/env sh

aem_stop() {
    /usr/local/bin/aem instance --instance-${RUNMODE} stop
    exit 0
}

trap aem_stop INT TERM EXIT

# link stdout to container output
ln -sf /proc/1/fd/1 /opt/aem/home/var/instance/${RUNMODE}/crx-quickstart/logs/stdout.log

cd /opt || exit 1
/usr/local/bin/aem instance --instance-${RUNMODE} start

# tail error log in subshell to keep container running and allow for graceful shutdown
(tail -F /opt/aem/home/var/instance/${RUNMODE}/crx-quickstart/logs/error.log)
