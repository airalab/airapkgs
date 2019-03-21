let
  version     = "2.4.2";
  sha256      = "1maaypwzmxmjg90n6m6b9gvjqnn1fvl2mx9xmfxghgln5vx48vrr";
  cargoSha256 = "0wq2v2khqfrkppl24z322b27bimhkkpikxdgqsxrjh36yrp03a08";
in
  import ./parity.nix { inherit version sha256 cargoSha256; }
