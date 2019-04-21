#!/bin/sh

cd "$(dirname "$0")"

. ./vars

mount -t proc none root/proc
mount -t sysfs none root/sys

# for some reason python3 has issues with qemu
chroot root /usr/bin/eselect python set python2.7

mkdir -p root/etc/portage/env
mkdir -p root/etc/portage/package.env
mkdir -p root/etc/portage/package.use
mkdir -p root/etc/portage/package.accept_keywords

cat > root/etc/portage/env/test << __EOF__
FEATURES="${FEATURES} test"
__EOF__

cat > root/etc/portage/package.env/my << __EOF__
net-libs/gnutls test
__EOF__

cat > root/etc/portage/package.use/my << __EOF__
dev-libs/libxml2 python
net-libs/gnutls test-full cxx dane doc examples guile idn nls openssl pkcs11 seccomp tls-heartbeat tools
__EOF__

cat > root/etc/portage/package.accept_keywords/my << __EOF__
net-libs/gnutls ~${GENTOO_ARCH}
__EOF__
