#!/bin/sh

cd "$(dirname "$0")"

. ./vars

for v in $(export -p | sed -e 's/^export //' -e 's/=.*//'); do
	unset "${v}"
done

export TERM=xterm-256color

#export FEATURES="-usersandbox -cgroup -ipc-sandbox -network-sandbox -mount-sandbox -pid-sandbox"

/bin/chroot root /bin/sh -c ". /etc/profile && emerge net-libs/gnutls"
