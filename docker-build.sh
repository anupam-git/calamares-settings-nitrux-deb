#!/bin/bash

apt-get --yes update
apt-get --yes install git wget curl

git clone https://github.com/Nitrux/calamares-settings-nitrux --depth 1
(
    cd calamares-settings-nitrux

    apt-get --yes --no-install-recommends install devscripts lintian build-essential automake autotools-dev equivs
    mk-build-deps -i -t "apt-get --yes" -r

    ### Build Deb
    mkdir source
    mv ./* source/ # Hack for debuild
    cd source
    debuild -b -uc -us

    cd ..
    chmod 777 ./*.deb
    mv *.deb ../
)
