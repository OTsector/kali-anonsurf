#!/bin/bash

# Kali Anonsurf installer script

# original source: https://github.com/Und3rf10w/kali-anonsurf By: Und3rf10w
# edited by -07 https://github.com/OTsector/


if [ $(id -u) -ne 0 ]; then
	echo "This script must be ran as root"
	exit 1
fi
kVer=$(uname -r); kVer=${kVer::3}
if [[ $kVer != "4.9" ]]; then
	echo "This script is not for your kernel version"
	exit 1
fi
if [ ! -f /usr/bin/apt-get ]; then
	echo "This script is for Debian based systems only"
	exit 1
fi
curl -o i2p-debian-repo.key.asc https://geti2p.net/_static/i2p-debian-repo.key.asc
apt-key add i2p-debian-repo.key.asc
rm -rf ./i2p-debian-repo.key.asc
echo -e "deb https://deb.i2p2.de/ stretch main\ndeb-src https://deb.i2p2.de/ stretch main" > /etc/apt/sources.list.d/i2p.list
apt-get install libservlet3.0-java -y
if [ ! -f "libjetty8-java_8.1.16-4_all.deb" ]; then
	wget http://ftp.us.debian.org/debian/pool/main/j/jetty8/libjetty8-java_8.1.16-4_all.deb
fi
dpkg -i libjetty8-java_8.1.16-4_all.deb
apt-get install libecj-java libgetopt-java libservlet3.0-java glassfish-javaee ttf-dejavu i2p i2p-router libjbigi-jni
apt-get -f install

apt-get install -y i2p-keyring
apt-get install -y secure-delete tor i2p

dpkg-deb -b kali-anonsurf-deb-src/ kali-anonsurf.deb
dpkg -i kali-anonsurf.deb || (apt-get -f install && dpkg -i kali-anonsurf.deb)

exit 0


