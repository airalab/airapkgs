{ stdenv, pythonPackages }:

with pythonPackages;

buildPythonPackage rec { 
  name = "${pname}-${version}";
  version = "0.6.0";
  pname = "markerlib";

  src = fetchPypi {
    inherit pname version;
    sha256 = "1bp3nq35rbl8vsakj3kcxlzd64aaz0s9m5xij3qg8nqz8hwkknrg";
  };

  doCheck = false;

  meta = with stdenv.lib; {
    homepage = http://bitbucket.org/dholth/markerlib/;
    description = "A compiler for PEP 345 environment markers.";
    license = licenses.mit;
  }; 
}
