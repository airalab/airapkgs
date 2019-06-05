{ stdenv
, lib
, fetchFromGitHub
, buildPythonPackage
, findutils
, gnugrep
, gawk
, coreutils
, openssl
, openssh
, nettools
, procps
, shadow
, utillinux
, parted
, python
, python3Packages
, makeWrapper
, mock
, nose
, pytest
}:

with lib;

buildPythonPackage rec {
  pname   = "azure-agent";
  version = "2.2.40";

  patches = [ ./azure-agent-entropy.patch ];

  src = fetchFromGitHub {
    owner  = "Azure";
    repo   = "WALinuxAgent";
    rev    = "v${version}";
    sha256 = "14hpw9lkkia7gdl301fryjr7pyh3hrbb83dcpqnr31caqi8ywlyr";
  };

  doCheck = false;

  buildInputs = [ makeWrapper python python3Packages.wrapPython python3Packages.distro];
  runtimeDeps = [ findutils gnugrep gawk coreutils openssl openssh
                    nettools # for hostname
                    procps # for pidof
                    shadow # for useradd, usermod
                    utillinux # for (u)mount, fdisk, sfdisk, mkswap
                    parted
                ];
  pythonPath = [ python3Packages.pyasn1 ];

  checkInputs = [ pytest mock nose];
  postPatch = ''
      substituteInPlace config/66-azure-storage.rules  --replace /bin/sh "${stdenv.shell}"
      substituteInPlace config/99-azure-product-uuid.rules --replace /bin/chmod "${coreutils}/bin/chmod"
      substituteInPlace tests/test_agent.py --replace /usr/bin/openssl ${openssl}/bin/openssl
      substituteInPlace tests/common/test_conf.py --replace /usr/bin/openssl ${openssl}/bin/openssl
      substituteInPlace azurelinuxagent/common/conf.py --replace /usr/bin/openssl ${openssl}/bin/openssl
  '';

  postInstall = ''
    install -dm755 "$out/lib/udev/rules.d"
    install -m644 config/*.rules "$out/lib/udev/rules.d"
    mv bin $out/bin/
    wrapProgram "$out/bin/waagent" \
        --prefix PYTHONPATH : $PYTHONPATH \
        --prefix PATH : "${makeBinPath runtimeDeps}"
  '';

  meta = with stdenv.lib; {
    description = "Microsoft Azure Linux Guest Agent http://azure.microsoft.com/";
    homepage    = "https://github.com/Azure/WALinuxAgent/";
    license     = licenses.asl20;
    platforms   = platforms.unix;
    maintainers = with maintainers; [ spd ];
  };
}

