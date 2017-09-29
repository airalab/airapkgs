{ config, lib, pkgs, ... }:

with lib;
{
  imports = [ ../profiles/minimal.nix ];

  boot.kernelParams = [ "panic=1" "boot.panic_on_fail" ];

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
    parity.chain = "kovan";

    railway-game.enable = true;
  };

  networking.hostName = mkDefault "aira";

  users.extraUsers.user =
    { isNormalUser = true;
      description = "Demo user account";
      extraGroups = [ "wheel" ];
      password = "user";
      uid = 1000;
    };

  nix = {
    binaryCaches = [ https://cache.nixos.org https://hydra.aira.life ];
    binaryCachePublicKeys = [ "hydra.aira.life-1:StgkxSYBh18tccd4KUVmxHQZEUF7ad8m10Iw4jNt5ak=" ];
  };
}
