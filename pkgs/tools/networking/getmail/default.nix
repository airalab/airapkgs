{ stdenv, fetchurl, python2Packages }:

python2Packages.buildPythonApplication rec {
  pname = "getmail";
  version = "5.14";

  src = fetchurl {
    url = "http://pyropus.ca/software/getmail/old-versions/${pname}-${version}.tar.gz";
    sha256 = "1hcrd9h4g12f5gvl1djsbchcjry02ghq4icdr897s8v48pkrzagk";
  };

  doCheck = false;

  postPatch = ''
    # getmail spends a lot of effort to build an absolute path for
    # documentation installation; too bad it is counterproductive now
    sed -e '/datadir or prefix,/d' -i setup.py
  '';

  meta = {
    description = "A program for retrieving mail";
    maintainers = [ stdenv.lib.maintainers.raskin stdenv.lib.maintainers.domenkozar ];
    platforms = stdenv.lib.platforms.linux;

    homepage = "http://pyropus.ca/software/getmail/";
    inherit version;
    updateWalker = true;
    license = stdenv.lib.licenses.gpl2Plus;
  };
}
