{ stdenv, pythonPackages }:

with pythonPackages;

buildPythonPackage rec { 
  name = "${pname}-${version}";
  version = "0.4.4";
  pname = "catkin_tools";

  src = fetchPypi {
    inherit pname version;
    sha256 = "0sgkpsss11abhl55nq64y2j579yakqhwwh40bzsmfj824d8nv901";
  };

  propagatedBuildInputs = [ catkin_pkg pyyaml osrf_pycommon trollius futures ];

  doCheck = false;

  meta = with stdenv.lib; {
    homepage = https://github.com/catkin/catkin_tools;
    description = "The catkin Command-Line Interface (CLI) tool is the single point of entry for most of the functionality provided by this package.";
    license = licenses.apache2;
  }; 
}
