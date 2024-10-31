#!/usr/bin/env bash

sed -i "s/lumesque/$USER/g" ./flake.nix ./home/default.nix ./bin.nix
