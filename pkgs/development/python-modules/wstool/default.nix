{ stdenv, pythonPackages }:

with pythonPackages;

buildPythonApplication rec { 
  name = "${pname}-${version}";
  version = "0.1.13";
  pname = "wstool";

  src = fetchPypi {
    inherit pname version;
    sha256 = "0i024xd4c6386q9y7vhkb82vz3ba77wvwvfyfqh2m17p9gwx7bjf";
  };

  propagatedBuildInputs = [ vcstools pyyaml ];

  doCheck = false;

  meta = with stdenv.lib; {
    homepage = http://wiki.ros.org/wstool;
    description = "Command-line tools for maintaining a workspace of projects from multiple version-control systems.";
    license = licenses.bsd3;
  }; 
}
