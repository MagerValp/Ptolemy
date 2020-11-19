#!/bin/zsh


if [[ $( arch ) != arm64* ]]; then
    echo "Not ARM"
    exit 0
fi

if [[ -f "/System/Library/LaunchDaemons/com.apple.oahd.plist" ]]; then
    echo "Rosetta launch daemon is already present"
    exit 0
fi


echo "Waiting for network access"
. /etc/rc.common
CheckForNetwork
while [[ "${NETWORKUP}" != "-YES-" ]]; do
    sleep 5
    NETWORKUP=
    CheckForNetwork
done

while ! curl --silent http://captive.apple.com/hotspot-detect.html 2>/dev/null | grep -q Success; do
    sleep 5
done


echo "Triggering Rosetta install"
/usr/sbin/softwareupdate --install-rosetta --agree-to-license


exit 0
