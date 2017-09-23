{ config, lib, pkgs, ... }:

with lib;
let
  diskSize = 10000;
in
{
  system.build.airaImage = import ../../lib/make-disk-image.nix {
    name = "aira-image";
    configFile = ./aira-config-user.nix;
    format = "raw";
    inherit diskSize;
    inherit config lib pkgs;
  };

  imports = [ ./aira-config-user.nix ];
}
