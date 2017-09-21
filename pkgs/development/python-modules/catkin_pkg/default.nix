{ stdenv, pythonPackages }:

with pythonPackages;

buildPythonPackage rec { 
  name = "${pname}-${version}";
  version = "0.3.6";
  pname = "catkin_pkg";

  src = fetchPypi {
    inherit pname version;
    sha256 = "1wkar2s9lmmdra82zrx7il9jw6zszvrm6wsvklpkpnbxclghzzxb";
  };

  propagatedBuildInputs = [ docutils dateutil ];

  doCheck = false;

  patches = [ ./drop-argparse.patch ];

  meta = with stdenv.lib; {
    homepage = http://wiki.ros.org/catkin_pkg;
    description = "Standalone Python library for the catkin package system.";
    license = licenses.bsd3;
  }; 
}
