{ config, lib, pkgs, ... }:

with lib;
{
  imports = [ ../profiles/minimal.nix ];

  boot.kernelParams = [ "panic=1" "boot.panic_on_fail" ];
  boot.supportedFilesystems = [ "btrfs" ];

  # Generate a GRUB menu.
  boot.loader = {
    grub.device = "/dev/sda";
    grub.version = 2;
    timeout = 0;
  };

  fileSystems."/".label = "nixos";

  services = {
    openssh.enable = true;
    parity.enable = true;
    railway-game.enable = true;
  };

  networking.hostName = mkDefault "aira";
}
