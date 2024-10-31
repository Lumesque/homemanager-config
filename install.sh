#!/usr/bin/env bash

function add_nix_flakes {
    echo "extra-experimental-features = flakes nix-command"
}

### Must have nix installed
if ! which nix 3>/dev/null 2>&1 ; then
    echo "Must have nix installed and set up in order to install..." >&2
    exit 1
fi

git clone https://github.com/Lumesque/homemanager-config ~/.config/home-manager
cd ~/.config/home-manager || exit 2
[ ! -d "/home/$USER/.config/nix" -o ! -f "/home/$USER/.config/nix/nix.conf" ] && mkdir ~/.config/nix && add_nix_flakes
[ -z "$(grep "flakes\|nix-command" /home/"$USER"/.config/nix/nix.conf)" ] &&  add_nix_flakes
chmod +x ./change-user.sh
./change-user.sh
nix build ".#homeConfigurations.$USER.activationPackage" && ./result/activate
