{ officialRelease ? false
  # The platforms for which we support.
, supportedSystems ? [ "x86_64-linux" "x86_64-darwin" "aarch64-linux" ]
  # Strip most of attributes when evaluating to spare memory usage
, scrubJobs ? true
  # Attributes passed to nixpkgs. Don't build packages marked as unfree.
, nixpkgsArgs ? { config = { allowUnfree = false; inHydra = true; }; }
}:

with import ../pkgs/top-level/release-lib.nix { inherit supportedSystems scrubJobs nixpkgsArgs; };

rec {
  parity = pkgs.parity;
  railway-market-switch = pkgs.railway-market-switch;
}
