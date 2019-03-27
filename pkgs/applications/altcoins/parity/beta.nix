let
  version     = "2.4.3";
  sha256      = "01h85fqpjs7kx3mrmk4rjmh6qhj8ql7ynx4v9q2iwb3i07a4fxn8";
  cargoSha256 = "0wq2v2khqfrkppl24z322b27bimhkkpikxdgqsxrjh36yrp03a08";
in
  import ./parity.nix { inherit version sha256 cargoSha256; }
