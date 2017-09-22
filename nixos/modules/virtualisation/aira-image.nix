{ config, lib, pkgs, ... }:

with lib;
let
  diskSize = 5120;
  fsType = "btrfs";
in
{
  system.build.airaImage = import ../../lib/make-disk-image.nix {
    name = "aira-image";
    configFile = ./aira-config-user.nix;
    format = "raw";
    inherit diskSize fsType;
    inherit config lib pkgs;
  };

  imports = [ ./aira-config-user.nix ];
}
