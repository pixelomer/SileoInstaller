#!/bin/bash
set -e

export THEOS_DEVICE_IP=0
export THEOS_DEVICE_PORT=2222

dm.pl -Zlzma package u0sileo.deb
scp -P ${THEOS_DEVICE_PORT} u0sileo.deb root@${THEOS_DEVICE_IP}:/tmp/_.deb
ssh -p${THEOS_DEVICE_PORT} root@${THEOS_DEVICE_IP} "dpkg -i /tmp/_.deb"