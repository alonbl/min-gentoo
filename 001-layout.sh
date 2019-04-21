#!/bin/sh

cd "$(dirname "$0")"

. ./vars

[ -x "/usr/bin/qemu-${ARCH}" ] || die "/usr/bin/qemu-${ARCH} is required but missing"
ldd "/usr/bin/qemu-${ARCH}" > /dev/null 2>&1 && die "/usr/bin/qemu-${ARCH} must be static linked"
[ -f "/proc/sys/fs/binfmt_misc/qemu-${ARCH}" ] || die "binfmt_misc configuration is missing"

mkdir -p downloads

if ! [ -f downloads/stage3.tar.xz ]; then
	x="$(curl -L "http://distfiles.gentoo.org/releases/${PORTAGE_ARCH}/autobuilds/latest-stage3.txt" | sed -e '/^#/d' -e '/multilib/d' -e 's/ .*//')"
	curl -L "http://distfiles.gentoo.org/releases/${PORTAGE_ARCH}/autobuilds/${x}" > downloads/stage3.tar.xz
fi

if ! [ -f downloads/portage-latest.tar.xz ]; then
	curl -L 'http://distfiles.gentoo.org/snapshots/portage-latest.tar.xz' > downloads/portage-latest.tar.xz
fi

mkdir -p root

tar -xpPsS -C root -f downloads/stage3.tar.xz
tar -xpPsS -C root/usr/ -f downloads/portage-latest.tar.xz

cp "/usr/bin/qemu-${ARCH}" root/usr/bin
