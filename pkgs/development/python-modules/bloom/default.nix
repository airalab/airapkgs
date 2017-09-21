{ stdenv, pythonPackages }:

with pythonPackages;

buildPythonApplication rec { 
  name = "${pname}-${version}";
  version = "0.5.26";
  pname = "bloom";

  src = fetchPypi {
    inherit pname version;
    sha256 = "0i024xd4c6386q9y7vhkb82vz3ba77wvwvfyfqh2m17p9gwx7bjf";
  };

  propagatedBuildInputs = [ ];

  doCheck = false;

  meta = with stdenv.lib; {
    homepage = http://www.ros.org/wiki/bloom;
    description = "Bloom is a release automation tool.";
    license = licenses.lgpl;
  }; 
}
