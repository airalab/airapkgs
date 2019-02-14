{ stdenv
, ros_comm
, mkRosPackage
, python3Packages
, python3
, fetchFromGitHub
}:

let
  rev = "73eaaa5493dc2088546755c18f83a7c0a26e7a3f";
  sha256 = "0w4dldiyqxxr54v1sik0nm4962hwi5fg784b7885vsc6jxwgjkp6";

in mkRosPackage rec {
  name = "${pname}-${version}";
  pname = "robonomics_comm";
  version = builtins.substring 0 8 rev;

  src = fetchFromGitHub {
    owner = "airalab";
    repo = pname;
    inherit rev sha256;
  };

  propagatedBuildInputs = with python3Packages;
  [ ros_comm web3 multihash voluptuous ipfsapi python-persistent-queue ];

  postInstall = ''
    patch $out/lib/${python3.libPrefix}/site-packages/ethereum_common/msg/_UInt256.py $src/ethereum_common/msg/_UInt256.py.patch
  '';

  meta = with stdenv.lib; {
    description = "Robonomics communication stack";
    homepage = http://github.com/airalab/robonomics_comm;
    license = licenses.bsd3;
    maintainers = [ maintainers.akru ];
  };
}
