kill -HUP $(cat /var/run/crond.pid)
/usr/lib/vmware/busybox/bin/busybox crond
