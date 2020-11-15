#!/bin/sh
hosts_dir=/etc/dnsmasq.hosts
unifi_hosts=$hosts_dir/unifi.hosts

if [ ! -z "$UNIFI_DOMAIN" ]; then
  UNIFI_OPTS="${UNIFI_OPTS} -d ${UNIFI_DOMAIN}"
fi

[ -d $hosts_dir ] || mkdir $hosts_dir
dnsmasq --keep-in-foreground --hostsdir=$hosts_dir --log-facility=- ${DNSMASQ_OPTS} &

while true; do
    ./get_unifi_reservations.py -u ${UNIFI_USERNAME} -p ${UNIFI_PASSWORD} ${UNIFI_OPTS} > /tmp/current_unifi.hosts
    if [ $? = 0 ] && ! diff -N $unifi_hosts /tmp/current_unifi.hosts; then
        mv /tmp/current_unifi.hosts $unifi_hosts
    fi
    sleep ${UNIFI_POLL_INTERVAL:-60}
done
