#!/bin/sh

cd "$(dirname "$0")"

. ./vars

umount root/proc
umount root/sys
