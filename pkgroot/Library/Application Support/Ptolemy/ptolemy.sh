#!/bin/zsh


if [[ $( arch ) != arm64* ]]; then
    echo "Not ARM"
    exit 0
fi

if [[ -f "/Library/Apple/System/Library/LaunchDaemons/com.apple.oahd.plist" ]]; then
    echo "Rosetta launch daemon is already present"
    exit 0
fi

echo "Triggering Rosetta install"
/usr/sbin/softwareupdate --install-rosetta --agree-to-license


exit 0
