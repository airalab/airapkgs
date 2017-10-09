# This jobset is used to generate a NixOS channel that contains a
# AIRA subset of Nixpkgs.

{ nixpkgs ? { outPath = ./..; revCount = 56789; shortRev = "gfedcba"; }
, stableBranch ? false
, supportedSystems ? [ "x86_64-linux" ] # no i686-linux
}:

with import ../lib;

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

  forAllSystems = genAttrs supportedSystems;

  makeImage =
    { module, maintainers ? ["akru"], system }:

    with import nixpkgs { inherit system; };

    hydraJob ((import lib/eval-config.nix {
      inherit system;
      modules = [ module ];
    }).config.system.build.airaImage);

in rec {

  nixos = {
    inherit (nixos') channel iso_minimal;
    tests = {
      inherit (nixos'.tests)
        simple;
      installer = {
        inherit (nixos'.tests.installer)
          simple;
      };
    };
    image = forAllSystems (system: makeImage {
      module = ./modules/virtualisation/aira-image.nix;
      inherit system;
    });
  };

  nixpkgs = {
    inherit (nixpkgs')
      # AIRA modules
      railway-market-switch
      aira-proto

      # 3rd-party
      ros_comm
      parity
      rustc
      cargo

      # Nixpkgs tarball
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
        (all nixpkgs.railway-market-switch)
        (all nixpkgs.parity)
      ]
      ++ lib.collect lib.isDerivation nixos;
  });

}
