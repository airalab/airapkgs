{ callPackage, fetchFromGitHub }:

((callPackage ./cargo-vendor.nix {}).cargo_vendor {}).overrideAttrs (attrs: {
  src = fetchFromGitHub {
    owner = "alexcrichton";
    repo = "cargo-vendor";
    rev = "0.1.23";
    sha256 = "1bwxz7jv92c9ygp3a1j822z2cciml4mf244viax1vv3j5np8k80v";
  };
})
