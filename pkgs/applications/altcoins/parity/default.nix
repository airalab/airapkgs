let
  version     = "2.3.7";
  sha256      = "1cfb75jlgrf96cplkqdns0cyapmibib4cbbr3whwf3h6xn1kjb0g";
  cargoSha256 = "09rpmybasn71cb59myd0l19djy0j8cxs9m5d3l6nylhgpy8qilcg";
in
  import ./parity.nix { inherit version sha256 cargoSha256; }
