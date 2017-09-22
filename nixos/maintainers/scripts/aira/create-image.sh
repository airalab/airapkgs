#! /bin/sh -e

export NIX_PATH=nixpkgs=../../../..
export NIXOS_CONFIG=$(dirname $(readlink -f $0))/../../../modules/virtualisation/aira-image.nix
export TIMESTAMP=$(date +%Y%m%d%H%M)

nix-build '<nixpkgs/nixos>' \
   -A config.system.build.airaImage --argstr system x86_64-linux -o aira -j 10
