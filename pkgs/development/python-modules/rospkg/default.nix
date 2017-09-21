{ stdenv, pythonPackages }:

with pythonPackages;

buildPythonPackage rec { 
  name = "${pname}-${version}";
  version = "1.1.2";
  pname = "rospkg";

  src = fetchPypi {
    inherit pname version;
    sha256 = "048hwx57p8rc2klcdkyspw2xnz5hs6kngfscigp3izvgy6yx0056";
  };

  propagatedBuildInputs = [ pyyaml ];

  doCheck = false;

  meta = with stdenv.lib; {
    homepage = http://wiki.ros.org/rospkg;
    description = "Standalone Python library for the ROS package system.";
    license = licenses.bsd3;
  }; 
}
