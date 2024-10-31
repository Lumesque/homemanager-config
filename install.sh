#!/usr/bin/env bash

### Must have nix installed
if ! which nix 3>/dev/null 2>&1 ; then
    echo "Must have nix installed and set up in order to install..." >&2
    exit 1
fi

git clone https://github.com/Lumesque/homemanager-config ~/.config/home-manager
cd ~/.config/home-manager || exit 2
chmod +x ./change-user.sh
./change-user.sh
nix build ".#homeConfigurations.$USER.activationPackage" && ./result/activate
