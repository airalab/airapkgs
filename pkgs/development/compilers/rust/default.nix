{ stdenv, callPackage, recurseIntoAttrs, makeRustPlatform, llvm, fetchurl
, targets ? []
, targetToolchains ? []
, targetPatches ? []
}:

let
  rustPlatform = recurseIntoAttrs (makeRustPlatform (callPackage ./bootstrap.nix {}));
  version = "1.20.0";
in
rec {
  rustc = callPackage ./rustc.nix {
    inherit llvm targets targetPatches targetToolchains rustPlatform version;

    configureFlags = [ "--release-channel=stable" ];

    src = fetchurl {
      url = "https://static.rust-lang.org/dist/rustc-${version}-src.tar.gz";
      sha256 = "0542y4rnzlsrricai130mqyxl8r6rd991frb4qsnwb27yigqg91a";
    };

    patches = [
      ./patches/darwin-disable-fragile-tcp-tests.patch
    ] ++ stdenv.lib.optional stdenv.needsPax ./patches/grsec.patch;

    forceBundledLLVM = true;

  };

  cargo = callPackage ./cargo.nix rec {
    version = "0.21.1";
    srcRev = "6084a2ba03aaa73794e6b86199e463ea6df290fe";
    srcSha = "1nz7sz7rzc6i1c0nzf6kmnmaq1l3hgrg19s589q7k309r6m7p7f7";
    depsSha256 = "1bwcf30iw4kf6kj71clk2k21ba7x00id7synili56sgd68w8b8n0";

    inherit rustc; # the rustc that will be wrapped by cargo
    inherit rustPlatform; # used to build cargo
  };
}
