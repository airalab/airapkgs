{ stdenv, pythonPackages }:

with pythonPackages;

buildPythonPackage rec { 
  name = "${pname}-${version}";
  version = "0.1.39";
  pname = "vcstools";

  src = fetchPypi {
    inherit pname version;
    sha256 = "1harbyc4x9qv0w4g0z8ixwaq8028kfks5vjzsk735d96lgndy6w4";
  };

  propagatedBuildInputs = [ pyyaml dateutil ];

  doCheck = false;

  meta = with stdenv.lib; {
    homepage = http://docs.ros.org/independent/api/vcstools/html/;
    description = "Python library for interacting with various VCS systems.";
    license = licenses.bsd3;
  }; 
}
