{ stdenv, buildGo111Package, go_1_11, gx, gx-go, fetchFromGitHub, fetchgx }:

let
  fetchgx' = fetchgx.override {
    go = go_1_11;
    gx = gx.override { buildGoPackage = buildGo111Package; };
    gx-go = gx-go.override { buildGoPackage = buildGo111Package; }; 
  };
  buildGoPackage = buildGo111Package; 

in buildGoPackage rec {
  name = "ipfs-${version}";
  version = "0.4.19";
  rev = "v${version}";

  goPackagePath = "github.com/ipfs/go-ipfs";

  extraSrcPaths = [
    (fetchgx' {
      inherit name src;
      sha256 = "0bj2kzxjssp7szp1wr9pp08bsi55jgf0k7gi4h70phlib2q673j2";
    })
  ];

  src = fetchFromGitHub {
    owner = "ipfs";
    repo = "go-ipfs";
    inherit rev;
    sha256 = "061mgkawimhw3gq506h8m6kw50a2v26qysa5kc5jdqgaqx5yvqh4";
  };

  meta = with stdenv.lib; {
    description = "A global, versioned, peer-to-peer filesystem";
    homepage = https://ipfs.io/;
    license = licenses.mit;
    platforms = platforms.unix;
    maintainers = with maintainers; [ fpletz ];
  };
}
