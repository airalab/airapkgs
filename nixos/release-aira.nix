# This jobset is used to generate a NixOS channel that contains a
# AIRA subset of Nixpkgs.

{ nixpkgs ? { outPath = ./..; revCount = 56789; shortRev = "gfedcba"; }
, stableBranch ? false
, supportedSystems ? [ "x86_64-linux" ] # no i686-linux
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
    inherit (nixos') channel iso_minimal dummy;
    tests = {
      inherit (nixos'.tests)
        ipv6
        login
        openssh
        simple;
      installer = {
        inherit (nixos'.tests.installer)
          simple;
      };
    };
  };

  nixpkgs = {
    inherit (nixpkgs')
      railway-market-switch
      ros_comm
      parity
      tarball;
  };

  tested = lib.hydraJob (pkgs.releaseTools.aggregate {
    name = "nixos-${nixos.channel.version}";
    meta = {
      description = "Release-critical builds for the AIRA channel";
      maintainers = [ lib.maintainers.akru ];
    };
    constituents =
      let all = x: map (system: x.${system}) supportedSystems; in
      [ nixpkgs.tarball
      ]
      ++ lib.collect lib.isDerivation nixos;
  });

}
