# This jobset is used to generate a NixOS channel that contains a
# small subset of Nixpkgs, mostly useful for servers that need fast
# security updates.

{ nixpkgs ? { outPath = (import ../lib).cleanSource ./..; revCount = 56789; shortRev = "gfedcba"; }
, stableBranch ? false
, supportedSystems ? [ "x86_64-linux" "aarch64-linux" ]
}:

let

  nixpkgsSrc = nixpkgs; # urgh

  pkgs = import ./.. {};

  lib = pkgs.lib;

  nixos' = import ./release.nix {
    inherit stableBranch supportedSystems;
    nixpkgs = nixpkgsSrc;
  };

  nixpkgs' = builtins.removeAttrs (import ../pkgs/top-level/release.nix {
    inherit supportedSystems;
    nixpkgs = nixpkgsSrc;
  }) [ "unstable" ];

in rec {

  nixos = {
    inherit (nixos') channel;
    tests = {
      inherit (nixos'.tests)
        ipfs
        ipv6
        cjdns
        parity;
    };
  };

  # A bootable VirtualBox virtual appliance as an OVA file (i.e. packaged OVF).
  ova_image = with import nixpkgsSrc { system = "x86_64-linux"; };
    lib.hydraJob ((import lib/eval-config.nix {
      inherit system;
      modules =
        [ ./modules/installer/virtualbox-minimal.nix
          ./modules/installer/aira.nix
        ];
    }).config.system.build.virtualBoxOVA);

  # A bootable SD card image
  sd_image = with import nixpkgsSrc { system = "aarch64-linux"; };
    lib.hydraJob ((import lib/eval-config.nix {
      inherit system;
      modules =
        [ ./modules/installer/cd-dvd/sd-image-aarch64.nix
          ./modules/installer/aira.nix
        ];
    }).config.system.build.sdImage);

  nixpkgs = {
    inherit (nixpkgs')
      tarball

      ipfs
      parity
      parity-beta

      ros_comm
      rosserial
      mavros
      dji_sdk

      aira-graph
      robonomics_dev
      robonomics_comm
      robonomics_comm-gen4
      robonomics-tools;
  };

  tested = lib.hydraJob (pkgs.releaseTools.aggregate {
    name = "nixos-${nixos.channel.version}";
    meta = {
      description = "Release-critical builds for the AIRA channel";
      maintainers = with lib.maintainers; [ akru ];
    };
    constituents =
      let all = x: map (system: x.${system}) supportedSystems; in
      [ nixpkgs.tarball
        (all nixpkgs.aira-graph)
        (all nixpkgs.robonomics_dev)
        (all nixpkgs.robonomics_comm)
        (all nixpkgs.robonomics_comm-gen4)
        (all nixpkgs.robonomics-tools)
        (all nixpkgs.ipfs)
        (all nixpkgs.parity)
        (all nixpkgs.parity-beta)
      ]
      ++ lib.collect lib.isDerivation nixos;
  });

}
